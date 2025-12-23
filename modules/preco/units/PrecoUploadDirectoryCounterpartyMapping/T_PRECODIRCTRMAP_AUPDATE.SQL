/* Триггер после исправления */
create or replace trigger T_PRECODIRCTRMAP_AUPDATE
  after update on PRECODIRCTRMAP for each row
begin
  /* дополнительная обработка после исправления записи раздела */
  P_LOG_UPDATE( :new.RN,'PrecoUploadDirectoryCounterpartyMapping',:new.BLREPCRN,:old.BLREPCRN,null,null );
end;
/
show errors trigger T_PRECODIRCTRMAP_AUPDATE;
