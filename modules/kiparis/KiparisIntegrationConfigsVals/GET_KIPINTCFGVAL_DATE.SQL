/* Функция получения значения параметра конфигурации интеграции в виде даты */
create or replace function GET_KIPINTCFGVAL_DATE
(
  nKIPINTCFG              in number,    -- Регистрационный номер конфигурации 
  sPARAM_CODE             in varchar2   -- Код параметра
) 
return date
as
begin
  return PKG_KIPINTCFG.GET_VAL_DATE(nKIPINTCFG, sPARAM_CODE);
end;
/
show errors function GET_KIPINTCFGVAL_DATE;