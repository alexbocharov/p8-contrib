/* Базовое удаление */
create or replace procedure P_PRECOOUTEXJRHST_BASE_DELETE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number        -- Организация
)
as
begin
  /* удаление записи из таблицы */
  delete
    from PRECOOUTEXJRHST
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournalHistory' );
  end if;
end;
/
show errors procedure P_PRECOOUTEXJRHST_BASE_DELETE;
