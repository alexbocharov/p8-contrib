/* Считывание записи */
create or replace procedure P_PRECODIRCTRMAP_EXISTS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nCRN                      out number       -- Каталог
)
as
begin
  /* поиск записи */
  begin
    select CRN
      into nCRN
      from PRECODIRCTRMAP
     where RN = nRN
       and COMPANY = nCOMPANY;
  exception
    when NO_DATA_FOUND then
      PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoUploadDirectoryCounterpartyMapping' );
  end;
end;
/
show errors procedure P_PRECODIRCTRMAP_EXISTS;
