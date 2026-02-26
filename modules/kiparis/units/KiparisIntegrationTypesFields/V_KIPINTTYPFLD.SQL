/* Кипарис. Виды интеграций (Поля) */
create or replace view V_KIPINTTYPFLD
(
  nRN,                                  -- Регистрационный номер
  nPRN,                                 -- Родитель
  sFLD_CODE,                            -- Код параметра
  sFLD_NAME,                            -- Наименование параметра
  nENTRY_TYPE,                          -- Способ формирования
  nDATA_TYPE,                           -- Тип данных
  nSTPOLICY,                            -- Политика хранения
  sBUNDLE                               -- Группа для объединения в один секрет
)
as
select
  T.RN,                                 -- nRN
  T.PRN,                                -- nPRN
  T.FLD_CODE,                           -- sFLD_CODE
  T.FLD_NAME,                           -- sFLD_NAME
  T.ENTRY_TYPE,                         -- nENTRY_TYPE
  T.DATA_TYPE,                          -- nDATA_TYPE
  T.STPOLICY,                           -- nSTPOLICY
  T.BUNDLE                              -- sBUNDLE
from
  KIPINTTYPFLD T
where exists (select null from V_USERPRIV UP where UP.UNITCODE = 'KiparisIntegrationTypes');
