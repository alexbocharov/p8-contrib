/* Базовое удаление */
create or replace procedure P_KIPINTCFG_BASE_DELETE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number        -- Организация
)
as
begin
  /* удаление записи из таблицы */
  delete
    from KIPINTCFG
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationConfigs' );
  end if;
end;
/
show errors procedure P_KIPINTCFG_BASE_DELETE;
