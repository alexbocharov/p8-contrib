/* Триггер после удаления */
create or replace trigger T_KIPINTCFGVAL_ADELETE
  after delete on KIPINTCFGVAL for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'KiparisIntegrationConfigsVals' );
end;
/
show errors trigger T_KIPINTCFGVAL_ADELETE;
