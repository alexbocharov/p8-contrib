/* Считывание записи */
create or replace procedure P_PRECOOUTEXJR_EXISTS
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
      from PRECOOUTEXJR
     where RN = nRN
       and COMPANY = nCOMPANY;
  exception
    when NO_DATA_FOUND then
      PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournal' );
  end;
end;
/
show errors procedure P_PRECOOUTEXJR_EXISTS;
