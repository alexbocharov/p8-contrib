/* Разрешение ссылок */
create or replace procedure P_PRECODIRCTRMAP_JOINS
(
  nCOMPANY                  in number,       -- Регистрационный номер организации
  sAGNABBR                  in varchar2,     -- Мнемокод контрагента
  sBLREPCRN_NAME            in varchar2,     -- Каталог загрузки
  nAGENT                    out number,      -- Ссылка на контрагента
  nBLREPCRN                 out number       -- Ссылка на каталог (Первичные\Сводные отчеты)
)
as
begin
  /* Поиск записи контрагента */
  FIND_AGNLIST_CODE( 0,0,nCOMPANY,sAGNABBR,nAGENT );
  /* Поиск записи каталога */
  FIND_ACATALOG_NAME( 0,nCOMPANY,null,'BalanceReports',sBLREPCRN_NAME,nBLREPCRN );
end;
/
show errors procedure P_PRECODIRCTRMAP_JOINS;
