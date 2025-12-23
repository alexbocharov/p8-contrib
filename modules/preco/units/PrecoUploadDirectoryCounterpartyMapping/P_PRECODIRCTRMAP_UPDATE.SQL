/* Исправление записи сопоставления */
create or replace procedure P_PRECODIRCTRMAP_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sAGNABBR                  in varchar2,     -- Мнемокод контрагента
  sBLREPCRN_NAME            in varchar2      -- Каталог загрузки
)
as
  nCRN                      PKG_STD.tREF;    -- Каталог
  nBLREPCRN                 PKG_STD.tREF;    -- Ссылка на каталог (Первичные\Сводные отчеты)
  nAGENT                    PKG_STD.tREF;    -- Ссылка на контрагента
begin
  /* Считывание записи */
  P_PRECODIRCTRMAP_EXISTS
  (
    nRN,
    nCOMPANY,
    nCRN
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,nCRN,null,null,'PrecoUploadDirectoryCounterpartyMapping','PRECODIRCTRMAP_UPDATE','PRECODIRCTRMAP',nRN );

  /* Разрешение ссылок */
  P_PRECODIRCTRMAP_JOINS
  (
    nCOMPANY,
    sAGNABBR,
    sBLREPCRN_NAME,
    nAGENT,
    nBLREPCRN
  );

  /* Базовое исправление */
  P_PRECODIRCTRMAP_BASE_UPDATE
  (
    nRN,
    nCOMPANY,
    nAGENT,
    nBLREPCRN
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,nCRN,null,null,'PrecoUploadDirectoryCounterpartyMapping','PRECODIRCTRMAP_UPDATE','PRECODIRCTRMAP',nRN );
end;
/
show errors procedure P_PRECODIRCTRMAP_UPDATE;
