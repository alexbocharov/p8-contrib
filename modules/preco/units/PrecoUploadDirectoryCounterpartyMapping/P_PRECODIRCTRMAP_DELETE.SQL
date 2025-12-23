/* Удаление записи сопоставления */
create or replace procedure P_PRECODIRCTRMAP_DELETE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number        -- Организация
)
as
  nCRN                      PKG_STD.tREF;    -- Каталог
begin
  /* Считывание записи */
  P_PRECODIRCTRMAP_EXISTS
  (
    nRN,
    nCOMPANY,
    nCRN
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,nCRN,null,null,'PrecoUploadDirectoryCounterpartyMapping','PRECODIRCTRMAP_DELETE','PRECODIRCTRMAP',nRN );
  /* Базовое удаление */
  P_PRECODIRCTRMAP_BASE_DELETE
  (
    nRN,
    nCOMPANY
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,nCRN,null,null,'PrecoUploadDirectoryCounterpartyMapping','PRECODIRCTRMAP_DELETE','PRECODIRCTRMAP',nRN );
end;
/
show errors procedure P_PRECODIRCTRMAP_DELETE;
