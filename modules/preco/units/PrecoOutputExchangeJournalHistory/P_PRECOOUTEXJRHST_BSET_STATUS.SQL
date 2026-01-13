/* Базовое изменение статуса истории журнала */
create or replace procedure P_PRECOOUTEXJRHST_BSET_STATUS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2,     -- Текст ошибки
  dUPDATED                  in date          -- Дата модификации
)
as
  nPRN                      PKG_STD.tREF;
begin
  /* изменение статуса в таблице */
  update PRECOOUTEXJRHST
     set STATUS = sSTATUS,
         ERR_CODE = sERR_CODE,
         ERR_TEXT = sERR_TEXT,
         UPDATED = dUPDATED
   where RN = nRN
     and COMPANY = nCOMPANY
  returning PRN into nPRN;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournalHistory' );
  end if;

  /* изменение статуса в журнале */
  P_PRECOOUTEXJR_BSET_STATUS( nPRN,nCOMPANY,sSTATUS,dUPDATED );
end;
/
show errors procedure P_PRECOOUTEXJRHST_BSET_STATUS;