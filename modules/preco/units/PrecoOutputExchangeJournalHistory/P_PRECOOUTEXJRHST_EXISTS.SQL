/* Считывание записи */
create or replace procedure P_PRECOOUTEXJRHST_EXISTS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nCRN                      out number,      -- Каталог
  nJUR_PERS                 out number       -- Ссылка на юридическое лицо
)
as
begin
  /* поиск записи */
  begin
    select CRN,JUR_PERS
      into nCRN,nJUR_PERS
      from PRECOOUTEXJRHST
     where RN = nRN
       and COMPANY = nCOMPANY;
  exception
    when NO_DATA_FOUND then
      PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournalHistory' );
  end;
end;
/
show errors procedure P_PRECOOUTEXJRHST_EXISTS;
