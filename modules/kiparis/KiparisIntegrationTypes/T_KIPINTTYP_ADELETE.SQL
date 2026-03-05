/* Триггер после удаления */
create or replace trigger T_KIPINTTYP_ADELETE
  after delete on KIPINTTYP for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'KiparisIntegrationTypes' );
end;
/
show errors trigger T_KIPINTTYP_ADELETE;
