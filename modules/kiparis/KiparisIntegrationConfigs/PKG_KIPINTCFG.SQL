/* 
  Пакет для получения параметров интеграции из таблицы KIPINTCFG.
  Включает авто-дешифрацию для секретов, хранящихся в зашифрованном виде.
*/
create or replace package PKG_KIPINTCFG
as
  /* Получить строковое значение (авто-дешифрация для секретов) */
  function GET_VAL_STR
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации 
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return varchar2;

  /* Получить числовое значение */
  function GET_VAL_NUM
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации 
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return number;

  /* Получить дату */
  function GET_VAL_DATE
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return date;

  /* Получить ссылку на Vault */
  function GET_VAL_REF
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return varchar2;
end PKG_KIPINTCFG;
/
show errors package PKG_KIPINTCFG;