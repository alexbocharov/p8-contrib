create or replace package body PKG_PRECO_EXCHANGE
as
  procedure GET_RECORD_BY_RN
  (
    nRN                     in     number,        -- Регистрационный номер
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с записью
  )
  as
  begin
    open pCURSOR for
      select
        T.RN            as nRN,
        T.ID            as sID,
        A.AGNIDNUMB     as sINN,
        A.REASON_CODE   as sKPP,
        T.REPORT_CODE   as sREPORT_CODE,
        T.REPORT_DATE   as dREPORT_DATE,
        T.SENDER_CODE   as sSENDER_CODE,
        T.CONTENT       as bCONTENT
      from
        PRECOOUTEXJR T
          inner join JURPERSONS J on J.RN = T.JUR_PERS
          inner join AGNLIST    A on A.RN = J.AGENT
      where T.RN = nRN;
    
    if SQL%NOTFOUND then
      P_EXCEPTION( 0,'Не найдена запись журнала обмена с регистрационным номером '||nRN );
    end if;
  end;

  procedure GET_PENDING_FOR_QUEUE
  (
    nLIMIT                  in     number,        -- Лимит записей
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с регистрационными номерами
  )
  as
  begin
    open pCURSOR for
      select RN as nRN
        from PARUS.PRECOOUTEXJR
       where ROWID IN (
             select RID
               from (
                    select ROWID as RID
                      from PARUS.PRECOOUTEXJR
                     where STATUS in ('NEW', 'UPDATED')
                     order by RN
                    )
              where ROWNUM <= nLIMIT
             )
         for update skip locked;
  end;

  procedure GET_PENDING_FOR_STATUS_CHK
  (
    nLIMIT                  in     number,        -- Лимит записей
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с идентификаторами сообщений
  )
  as
  begin
    open pCURSOR for
      select ID as sID
        from PARUS.PRECOOUTEXJR
       where ROWID IN (
             select RID
               from (
                    select ROWID as RID
                      from PARUS.PRECOOUTEXJR
                     where STATUS in ('SENT', 'PROCESSING_QUEUE', 'PROCESSING', 'PROCESSED')
                     order by RN
                    )
              where ROWNUM <= nLIMIT
             )
         for update skip locked;
  end;

  procedure SET_STATUS
  (
    nRN                     in number,       -- Регистрационный номер
    sSTATUS                 in varchar2,     -- Статус
    sERR_CODE               in varchar2,     -- Код ошибки
    sERR_TEXT               in varchar2      -- Текст ошибки
  )
  as
    nHST_RN                 PKG_STD.tREF;
    nCOMPANY                PKG_STD.tREF;
  begin
    begin
      /* Определяем актуальную запись истории */
      select RN, COMPANY
        into nHST_RN, nCOMPANY
        from PRECOOUTEXJRHST
      where PRN = nRN
        and NUMB = (select max(NUMB) from PRECOOUTEXJRHST where PRN = nRN);

      /* изменение статуса */
      P_PRECOOUTEXJRHST_BSET_STATUS( nHST_RN,nCOMPANY,sSTATUS,sERR_CODE,sERR_TEXT,SYSDATE );
    exception
      when NO_DATA_FOUND then
        P_EXCEPTION( 0,'Не найдена запись истории журнала обмена с регистрационным номером '||nRN );
    end;
end;

end PKG_PRECO_EXCHANGE;
/
show errors package body PKG_PRECO_EXCHANGE;