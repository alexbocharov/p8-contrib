/* Базовое исправление */
create or replace procedure P_PRECOINEXJRHST_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nPRN                      in number,       -- Родитель
  nNUMB                     in number,       -- Порядковый номер
  sID                       in varchar2,     -- Идентификатор экземпляра отчёта
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2,     -- Текст ошибки
  dUPDATED                  in date          -- Дата модификации
)
as
begin
  /* исправление записи в таблице */
  update PRECOINEXJRHST
     set PRN = nPRN,
         NUMB = nNUMB,
         ID = sID,
         STATUS = sSTATUS,
         ERR_CODE = sERR_CODE,
         ERR_TEXT = sERR_TEXT,
         UPDATED = dUPDATED
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoInputExchangeJournalHistory' );
  end if;
end;
/
show errors procedure P_PRECOINEXJRHST_BASE_UPDATE;
