/* Изменение статуса журнала и истории */
create or replace procedure P_PRECOOUTEXJR_SET_STATUS_EX
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2,     -- Текст ошибки
  dUPDATED                  in date          -- Дата модификации
)
as
  nHST_RN                   PKG_STD.tREF;
begin
  begin
    /* Определяем актуальную запись истории */
    select RN
      into nHST_RN
      from PRECOOUTEXJRHST
     where COMPANY = nCOMPANY
       and PRN = nRN
       and NUMB = (select max(NUMB) from PRECOOUTEXJRHST where COMPANY = nCOMPANY and PRN = nRN);

    /* изменение статуса */
    P_PRECOOUTEXJRHST_BSET_STATUS( nHST_RN,nCOMPANY,sSTATUS,sERR_CODE,sERR_TEXT,dUPDATED );
  exception
    when NO_DATA_FOUND then
      P_EXCEPTION( 0,'Не найдена запись истории журнала обмена с регистрационным номером '||nRN );
  end;
end;
/
show errors procedure P_PRECOOUTEXJR_SET_STATUS_EX;