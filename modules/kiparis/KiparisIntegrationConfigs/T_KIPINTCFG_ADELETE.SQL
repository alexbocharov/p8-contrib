/* Триггер после удаления */
create or replace trigger T_KIPINTCFG_ADELETE
  after delete on KIPINTCFG for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'KiparisIntegrationConfigs' );
end;
/
show errors trigger T_KIPINTCFG_ADELETE;
