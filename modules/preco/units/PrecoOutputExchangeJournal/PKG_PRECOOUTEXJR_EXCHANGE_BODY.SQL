create or replace package body PKG_PRECOOUTEXJR_EXCHANGE
as
  procedure GET_BATCH_FOR_SENDING
  (
    nBATCH_SIZE             in number,            -- Размер пакета
    pCURSOR                 out sys_refcursor     -- Курсор с метаданными передаваемых отчётов
  )
  as
    aRN_LIST                sys.odcinumberlist;
    dCURRENT                date;
  begin
    /* Получение пакета записей для отправки */
    select RN
      bulk collect into aRN_LIST
      from PRECOOUTEXJR
     where ROWID IN (
            select RID
              from (
                  select ROWID as RID
                    from PARUS.PRECOOUTEXJR
                    where STATUS in ('NEW', 'UPDATED')
                    order by RN
                  )
            where ROWNUM <= nBATCH_SIZE
            )
        for update skip locked;

    if aRN_LIST.count > 0 then
      /* Обновление статусов выбранных записей на "В очереди на отправку" */
      for i in 1..aRN_LIST.count loop
        dCURRENT := SYSDATE;

        update PRECOOUTEXJR
           set STATUS = sSTATUS_QUEUED,
               UPDATED = dCURRENT
         where RN = aRN_LIST(i);

        update PRECOOUTEXJRHST 
           set STATUS = sSTATUS_QUEUED,
               UPDATED = dCURRENT
         where PRN = aRN_LIST(i)
           and NUMB = (select max(NUMB) from PRECOOUTEXJRHST where PRN = aRN_LIST(i));
      end loop;

      /* Возврат курсора с метаданными выбранных записей */
      open pCURSOR for
        select
          T.ID            as sID,
          A.AGNIDNUMB     as sINN,
          A.REASON_CODE   as sKPP,
          T.REPORT_CODE   as sREPORT_CODE,
          T.REPORT_DATE   as dREPORT_DATE,
          T.SENDER_CODE   as sSENDER_CODE
        from
          PRECOOUTEXJR T
            inner join JURPERSONS J on J.RN = T.JUR_PERS
            inner join AGNLIST    A on A.RN = J.AGENT
       where T.RN in (select column_value from table(aRN_LIST));
    else
      /* Нет записей для отправки */
      open pCURSOR for
        select
          T.ID            as sID,
          A.AGNIDNUMB     as sINN,
          A.REASON_CODE   as sKPP,
          T.REPORT_CODE   as sREPORT_CODE,
          T.REPORT_DATE   as dREPORT_DATE,
          T.SENDER_CODE   as sSENDER_CODE
        from
          PRECOOUTEXJR T
            inner join JURPERSONS J on J.RN = T.JUR_PERS
            inner join AGNLIST    A on A.RN = J.AGENT
       where 1 = 0;
    end if;
  end;

  procedure GET_CONTENT_BY_ID
  (
    sID                     in varchar2,          -- Идентификатор экземпляра отчета
    pCLOB                   out clob              -- CLOB с содержимым отчёта
  )
  as
  begin
    select CONTENT
      into pCLOB
      from PRECOOUTEXJR
     where ID = sID;

    if SQL%NOTFOUND then
      P_EXCEPTION( 0,'Не найдено содержимое журнала обмена с идентификатором '||sID );
    end if;
  end;

  procedure GET_RECORD_BY_ID
  (
    sID                     in     varchar2,      -- Идентификатор экземпляра отчета
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с записью
  )
  as
  begin
    open pCURSOR for
      select
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
      where T.ID = sID;

    if SQL%NOTFOUND then
      P_EXCEPTION( 0,'Не найдена запись журнала обмена с идентификатором '||sID );
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
      select ID as sID
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
    sID                     in varchar2,     -- Идентификатор экземпляра отчета
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
      where ID = sID
        and NUMB = (select max(NUMB) from PRECOOUTEXJRHST where ID = sID);

      /* изменение статуса */
      P_PRECOOUTEXJRHST_BSET_STATUS( nHST_RN,nCOMPANY,sSTATUS,sERR_CODE,sERR_TEXT,SYSDATE );
    exception
      when NO_DATA_FOUND then
        P_EXCEPTION( 0,'Не найдена запись истории журнала обмена с идентификатором '||sID );
    end;
end;

end PKG_PRECOOUTEXJR_EXCHANGE;
/
show errors package body PKG_PRECOOUTEXJR_EXCHANGE;