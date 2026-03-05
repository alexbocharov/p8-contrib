/* Триггер после удаления */
create or replace trigger T_KIPINTTYPFLD_ADELETE
  after delete on KIPINTTYPFLD for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'KiparisIntegrationTypesFields' );
end;
/
show errors trigger T_KIPINTTYPFLD_ADELETE;
