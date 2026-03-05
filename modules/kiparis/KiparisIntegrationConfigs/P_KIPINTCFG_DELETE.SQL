/* Удаление настройки интеграции */
create or replace procedure P_KIPINTCFG_DELETE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number        -- Организация
)
as
  rKIPINTCFG                KIPINTCFG%rowtype; -- запись настройки интеграции
begin
  /* Считывание записи */
  P_KIPINTCFG_EXISTS
  (
    nRN,
    nCOMPANY,
    rKIPINTCFG
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,rKIPINTCFG.CRN,rKIPINTCFG.JUR_PERS,null,'KiparisIntegrationConfigs','KIPINTCFG_DELETE','KIPINTCFG',nRN );

  /* Базовое удаление */
  P_KIPINTCFG_BASE_DELETE
  (
    nRN,
    nCOMPANY
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,rKIPINTCFG.CRN,rKIPINTCFG.JUR_PERS,null,'KiparisIntegrationConfigs','KIPINTCFG_DELETE','KIPINTCFG',nRN );
end;
/
show errors procedure P_KIPINTCFG_DELETE;
