/* Процедура возвращает следующий код для новой записи в таблице KIPINTCFG, основываясь на максимальном существующем значении. */
create or replace procedure P_KIPINTCFG_GETNEXTCODE
(
  nCOMPANY                  in number,       -- Организация
  sCODE                     out varchar2     -- Следующий код
)
as
begin
  sCODE := GET_NEXT_CODE(nCOMPANY, 'KIPINTCFG', 'CODE', 20, 'KIP');
end;
/
show errors procedure P_KIPINTCFG_GETNEXTCODE;
