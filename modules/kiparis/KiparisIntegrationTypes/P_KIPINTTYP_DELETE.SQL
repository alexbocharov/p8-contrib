/* Удаление вида интеграции */
create or replace procedure P_KIPINTTYP_DELETE
(
  nRN                       in number        -- Регистрационный номер
)
as
begin
  /* Считывание записи */
  P_KIPINTTYP_EXISTS
  (
    nRN
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( null,null,null,null,null,'KiparisIntegrationTypes','KIPINTTYP_DELETE','KIPINTTYP',nRN );

  /* Базовое удаление */
  P_KIPINTTYP_BASE_DELETE
  (
    nRN
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( null,null,null,null,null,'KiparisIntegrationTypes','KIPINTTYP_DELETE','KIPINTTYP',nRN );
end;
/
show errors procedure P_KIPINTTYP_DELETE;
