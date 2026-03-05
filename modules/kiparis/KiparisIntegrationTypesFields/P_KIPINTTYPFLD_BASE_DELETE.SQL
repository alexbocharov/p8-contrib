/* Базовое удаление */
create or replace procedure P_KIPINTTYPFLD_BASE_DELETE
(
  nRN                       in number        -- Регистрационный номер
)
as
begin
  /* удаление записи из таблицы */
  delete
    from KIPINTTYPFLD
   where RN = nRN;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationTypesFields' );
  end if;
end;
/
show errors procedure P_KIPINTTYPFLD_BASE_DELETE;
