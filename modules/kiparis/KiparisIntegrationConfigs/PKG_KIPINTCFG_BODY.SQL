/* 
  Тело пакета для получения параметров интеграции из таблицы KIPINTCFG.
  Включает авто-дешифрацию для секретов, хранящихся в зашифрованном виде.
*/
create or replace package body PKG_KIPINTCFG
as
  /* Вспомогательная функция для поиска значения */
  function FIND_VAL_RECORD
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return KIPINTCFGVAL%rowtype 
  as
    rVAL                    KIPINTCFGVAL%rowtype;
  begin
    select V.* into rVAL
      from KIPINTCFGVAL V
            join KIPINTTYPFLD F on V.KIPINTTYPFLD = F.RN
     where V.PRN = nKIPINTCFG 
       and F.FLD_CODE = sPARAM_CODE;
    return rVAL;
  exception
    when NO_DATA_FOUND then return null;
  end;

  /* Получить строковое значение (авто-дешифрация для секретов) */
  function GET_VAL_STR
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return varchar2 
  as
    rVAL                    KIPINTCFGVAL%rowtype;
    nENTRY_TYPE             KIPINTTYPFLD.ENTRY_TYPE%type;
  begin
    rVAL := FIND_VAL_RECORD(nKIPINTCFG, sPARAM_CODE);
    if rVAL.RN is null then 
      return null; 
    end if;

    /* Проверяем, не является ли поле секретом (ENTRY_TYPE = 1) и при необходимости раскрываем его */
    select ENTRY_TYPE into nENTRY_TYPE from KIPINTTYPFLD where RN = rVAL.KIPINTTYPFLD;

    if nENTRY_TYPE = 1 then
       /* Автоматически раскрываем зашифрованные данные через KIP_SENTRY */
       return KIP_SENTRY.REVEAL(rVAL.RN, hextoraw(rVAL.VAL_STR));
    end if;

    return rVAL.VAL_STR;
  end;

  /* Получить числовое значение */
  function GET_VAL_NUM
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации 
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return number 
  as
    rVAL                    KIPINTCFGVAL%rowtype;
  begin
    rVAL := FIND_VAL_RECORD(nKIPINTCFG, sPARAM_CODE);
    return rVAL.VAL_NUM;
  end;

  /* Получить дату */
  function GET_VAL_DATE
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return date 
  as
    rVAL                    KIPINTCFGVAL%rowtype;
  begin
    rVAL := FIND_VAL_RECORD(nKIPINTCFG, sPARAM_CODE);
    return rVAL.VAL_DATE;
  end;

  /* Получить ссылку на Vault */
  function GET_VAL_REF
  (
    nKIPINTCFG              in number,    -- Регистрационный номер конфигурации
    sPARAM_CODE             in varchar2   -- Код параметра
  ) 
  return varchar2 
  as
    rVAL                    KIPINTCFGVAL%rowtype;
  begin
    rVAL := FIND_VAL_RECORD(nKIPINTCFG, sPARAM_CODE);
    return rVAL.VAL_REF;
  end;
end PKG_KIPINTCFG;
/
show errors package body PKG_KIPINTCFG;