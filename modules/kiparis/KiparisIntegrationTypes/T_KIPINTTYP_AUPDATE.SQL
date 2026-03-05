/* Триггер после исправления */
create or replace trigger T_KIPINTTYP_AUPDATE
  after update on KIPINTTYP for each row
begin
  /* дополнительная обработка после исправления записи раздела */
  P_LOG_UPDATE( :new.RN,'KiparisIntegrationTypes',null,null,null,null );
end;
/
show errors trigger T_KIPINTTYP_AUPDATE;
