/* Считывание записи */
create or replace procedure P_KIPINTTYPFLD_EXISTS
(
  nRN                       in number        -- Регистрационный номер
)
as
  nCOUNT                    number(17);
begin
  /* поиск записи */
  select count(*)
    into nCOUNT
    from KIPINTTYPFLD
   where RN = nRN;

  if (nCOUNT = 0) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationTypesFields' );
  end if;
end;
/
show errors procedure P_KIPINTTYPFLD_EXISTS;
