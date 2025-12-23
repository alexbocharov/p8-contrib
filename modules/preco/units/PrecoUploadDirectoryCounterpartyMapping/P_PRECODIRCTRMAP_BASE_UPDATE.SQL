/* Базовое исправление */
create or replace procedure P_PRECODIRCTRMAP_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nAGENT                    in number,       -- Ссылка на контрагента
  nBLREPCRN                 in number       -- Ссылка на каталог (Первичные\Сводные отчеты)
)
as
begin
  /* исправление записи в таблице */
  update PRECODIRCTRMAP
     set AGENT = nAGENT,
         BLREPCRN = nBLREPCRN
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoUploadDirectoryCounterpartyMapping' );
  end if;
end;
/
show errors procedure P_PRECODIRCTRMAP_BASE_UPDATE;
