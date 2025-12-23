/* Базовое удаление */
create or replace procedure P_PRECODIRCTRMAP_BASE_DELETE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number        -- Организация
)
as
begin
  /* удаление записи из таблицы */
  delete
    from PRECODIRCTRMAP
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoUploadDirectoryCounterpartyMapping' );
  end if;
end;
/
show errors procedure P_PRECODIRCTRMAP_BASE_DELETE;
