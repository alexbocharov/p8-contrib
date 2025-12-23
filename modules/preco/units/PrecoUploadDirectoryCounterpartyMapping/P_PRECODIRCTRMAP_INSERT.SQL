/* Добавление/размножение записи сопоставления */
create or replace procedure P_PRECODIRCTRMAP_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  sAGNABBR                  in varchar2,     -- Мнемокод контрагента
  sBLREPCRN_NAME            in varchar2,     -- Каталог загрузки
  nRN                       out number       -- Регистрационный номер
)
as
  nAGENT                    PKG_STD.tREF;    -- Ссылка на контрагента
  nBLREPCRN                 PKG_STD.tREF;    -- Ссылка на каталог (Первичные\Сводные отчеты)
begin
  /* Разрешение ссылок */
  P_PRECODIRCTRMAP_JOINS
  (
    nCOMPANY,
    sAGNABBR,
    sBLREPCRN_NAME,
    nAGENT,
    nBLREPCRN
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,nCRN,null,null,'PrecoUploadDirectoryCounterpartyMapping','PRECODIRCTRMAP_INSERT','PRECODIRCTRMAP' );

  /* Базовое добавление */
  P_PRECODIRCTRMAP_BASE_INSERT
  (
    nCOMPANY,
    nCRN,
    nAGENT,
    nBLREPCRN,
    nRN
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,nCRN,null,null,'PrecoUploadDirectoryCounterpartyMapping','PRECODIRCTRMAP_INSERT','PRECODIRCTRMAP',nRN );
end;
/
show errors procedure P_PRECODIRCTRMAP_INSERT;
