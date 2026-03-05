/* Считывание записи */
create or replace procedure P_KIPINTTYP_EXISTS
(
  nRN                       in number        -- Регистрационный номер
)
as
  nCOUNT                    number(17);
begin
  /* поиск записи */
  select count(*)
    into nCOUNT
    from KIPINTTYP
   where RN = nRN;

  if (nCOUNT = 0) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationTypes' );
  end if;
end;
/
show errors procedure P_KIPINTTYP_EXISTS;
