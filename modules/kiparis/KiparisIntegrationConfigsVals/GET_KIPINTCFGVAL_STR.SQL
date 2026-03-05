/* Функция поиска подстроки в CLOB */
create or replace function GET_KIPINTCFGVAL_STR
(
  nKIPINTCFG              in number,    -- Регистрационный номер конфигурации 
  sPARAM_CODE             in varchar2   -- Код параметра
) 
return varchar2
as
begin
  return PKG_KIPINTCFG.GET_VAL_STR(nKIPINTCFG, sPARAM_CODE);
end;
/
show errors function GET_KIPINTCFGVAL_STR;