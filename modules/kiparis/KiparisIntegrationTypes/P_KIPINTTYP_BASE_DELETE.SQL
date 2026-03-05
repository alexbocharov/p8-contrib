/* Базовое удаление */
create or replace procedure P_KIPINTTYP_BASE_DELETE
(
  nRN                       in number        -- Регистрационный номер
)
as
begin
  /* удаление записи из таблицы */
  delete
    from KIPINTTYP
   where RN = nRN;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationTypes' );
  end if;
end;
/
show errors procedure P_KIPINTTYP_BASE_DELETE;
