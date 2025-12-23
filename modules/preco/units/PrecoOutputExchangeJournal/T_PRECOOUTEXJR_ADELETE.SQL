/* Триггер после удаления */
create or replace trigger T_PRECOOUTEXJR_ADELETE
  after delete on PRECOOUTEXJR for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'PrecoOutputExchangeJournal' );
end;
/
show errors trigger T_PRECOOUTEXJR_ADELETE;
