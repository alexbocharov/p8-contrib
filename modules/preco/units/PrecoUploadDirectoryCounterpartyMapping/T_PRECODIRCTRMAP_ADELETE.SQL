/* Триггер после удаления */
create or replace trigger T_PRECODIRCTRMAP_ADELETE
  after delete on PRECODIRCTRMAP for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'PrecoUploadDirectoryCounterpartyMapping' );
end;
/
show errors trigger T_PRECODIRCTRMAP_ADELETE;
