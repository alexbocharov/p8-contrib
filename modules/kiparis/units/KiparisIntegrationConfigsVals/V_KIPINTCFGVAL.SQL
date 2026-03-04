/* Кипарис. Настройки интеграций (Параметры) */
create or replace view V_KIPINTCFGVAL
(
  nRN,                                  -- Регистрационный номер
  nCOMPANY,                             -- Организация
  nPRN,                                 -- Родитель
  nCRN,                                 -- Каталог
  nJUR_PERS,                            -- Ссылка на юридическое лицо
  nKIPINTTYPFLD,                        -- Ссылка на параметр вида интеграции
  sPARAM_CODE,                          -- Параметр
  sPARAM_NAME,                          -- Описание
  sVALUE                                -- Значение настройки
)
as
select
  T.RN,                                 -- nRN
  T.COMPANY,                            -- nCOMPANY
  T.PRN,                                -- nPRN
  T.CRN,                                -- nCRN
  T.JUR_PERS,                           -- nJUR_PERS
  T.KIPINTTYPFLD,                       -- nKIPINTTYPFLD
  K.FLD_CODE,                           -- sPARAM_CODE
  K.FLD_NAME,                           -- sPARAM_NAME
  case 
    -- Секреты и Бандлы (ENTRYTYPE 1 или 3) всегда маскируем
    when K.ENTRY_TYPE in (1, 3) and (T.VAL_REF is not null or T.VAL_STR is not null) then '********'
    -- Чекбоксы (ENTRYTYPE 2): 0 -> Нет, 1 -> Да
    when K.ENTRY_TYPE = 2 then decode(VAL_NUM, 1, 'Да', 'Нет')
    -- Обычные типы данных (DATA_TYPE)
    when K.DATA_TYPE = 0 then T.VAL_STR                           -- Строка
    when K.DATA_TYPE = 1 then to_char(T.VAL_NUM)                  -- Число
    when K.DATA_TYPE = 2 then to_char(T.VAL_DATE, 'dd.mm.yyyy')   -- Дата
    else T.VAL_STR -- По умолчанию отображаем как строку
  end as sVALUE                         -- sVALUE
from
  KIPINTCFGVAL T
  inner join KIPINTTYPFLD K on T.KIPINTTYPFLD = K.RN
where exists (select null from V_USERPRIV UP where UP.CATALOG = T.CRN)
  and exists (select null from V_USERPRIV UP where UP.JUR_PERS = T.JUR_PERS and UP.UNITCODE = 'KiparisIntegrationConfigs');
