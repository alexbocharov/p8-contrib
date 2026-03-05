/* Триггер после исправления */
create or replace trigger T_KIPINTCFG_AUPDATE
  after update on KIPINTCFG for each row
begin
  /* дополнительная обработка после исправления записи раздела */
  P_LOG_UPDATE( :new.RN,'KiparisIntegrationConfigs',:new.CRN,:old.CRN,:new.JUR_PERS,:old.JUR_PERS );
end;
/
show errors trigger T_KIPINTCFG_AUPDATE;
