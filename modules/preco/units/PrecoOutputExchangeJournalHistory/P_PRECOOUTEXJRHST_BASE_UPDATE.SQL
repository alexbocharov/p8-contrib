/* Базовое исправление */
create or replace procedure P_PRECOOUTEXJRHST_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nNUMB                     in number,       -- Порядковый номер
  sID                       in varchar2,     -- Идентификатор экземпляра отчёта
  sAUTHID                   in varchar2,     -- Пользователь
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2,     -- Текст ошибки
  dUPDATED                  in date          -- Дата модификации
)
as
begin
  /* исправление записи в таблице */
  update PRECOOUTEXJRHST
     set NUMB = nNUMB,
         ID = sID,
         AUTHID = sAUTHID,
         STATUS = sSTATUS,
         ERR_CODE = sERR_CODE,
         ERR_TEXT = sERR_TEXT,
         UPDATED = dUPDATED
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournalHistory' );
  end if;
end;
/
show errors procedure P_PRECOOUTEXJRHST_BASE_UPDATE;
