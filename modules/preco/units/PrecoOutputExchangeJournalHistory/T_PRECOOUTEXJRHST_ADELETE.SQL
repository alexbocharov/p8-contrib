/* Триггер после удаления */
create or replace trigger T_PRECOOUTEXJRHST_ADELETE
  after delete on PRECOOUTEXJRHST for each row
begin
  /* дополнительная обработка после удаления записи раздела */
  P_LOG_DELETE( :old.RN,'PrecoOutputExchangeJournalHistory' );
end;
/
show errors trigger T_PRECOOUTEXJRHST_ADELETE;
