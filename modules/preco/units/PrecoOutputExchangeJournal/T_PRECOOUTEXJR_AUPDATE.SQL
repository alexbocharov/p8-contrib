/* Триггер после исправления */
create or replace trigger T_PRECOOUTEXJR_AUPDATE
  after update on PRECOOUTEXJR for each row
begin
  /* дополнительная обработка после исправления записи раздела */
  P_LOG_UPDATE( :new.RN,'PrecoOutputExchangeJournal',:new.CRN,:old.CRN,:new.JUR_PERS,:old.JUR_PERS );
end;
/
show errors trigger T_PRECOOUTEXJR_AUPDATE;
