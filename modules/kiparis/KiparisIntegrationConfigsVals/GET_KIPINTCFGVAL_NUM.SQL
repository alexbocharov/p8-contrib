/* Функция получения числового значения параметра конфигурации */
create or replace function GET_KIPINTCFGVAL_NUM
(
  nKIPINTCFG              in number,    -- Регистрационный номер конфигурации 
  sPARAM_CODE             in varchar2   -- Код параметра
) 
return number
as
begin
  return PKG_KIPINTCFG.GET_VAL_NUM(nKIPINTCFG, sPARAM_CODE);
end;
/
show errors function GET_KIPINTCFGVAL_NUM;