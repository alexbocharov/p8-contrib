/* Базовое изменение статуса истории журнала */
create or replace procedure P_PRECOOUTEXJRHST_BSET_STATUS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sMSG_ID                   in varchar2,     -- Идентификатор сообщения
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2,     -- Текст ошибки
  dUPDATED                  in date          -- Дата модификации
)
as
begin
  /* изменение статуса в таблице */
  update PRECOOUTEXJRHST
     set STATUS = sSTATUS,
         ERR_CODE = sERR_CODE,
         ERR_TEXT = sERR_TEXT,
         UPDATED = dUPDATED
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournalHistory' );
  end if;

  /* Изменения статуса журнала */
  P_PRECOOUTEXJR_BSET_STATUS( nRN,nCOMPANY,sMSG_ID,sSTATUS,dUPDATED );
end;
/
show errors procedure P_PRECOOUTEXJRHST_BSET_STATUS;