/* Кипарис. Настройки интеграций */
create or replace view V_KIPINTCFG
(
  nRN,                                  -- Регистрационный номер
  nCOMPANY,                             -- Организация
  nCRN,                                 -- Каталог
  nJUR_PERS,                            -- Ссылка на юридическое лицо
  sJUR_PERS_CODE,                       -- Принадлежность
  nKIPINTTYP,                           -- Ссылка на вид интеграций КИПАРИС
  sKIPINTTYP_CODE,                      -- Вид интеграции
  sCODE,                                -- Мнемокод
  sNAME,                                -- Наименование
  nWORK_MODE,                           -- Режим работы
  nIS_ACTIVE,                           -- Активна
  sNOTE                                 -- Примечание
)
as
select
  T.RN,                                 -- nRN
  T.COMPANY,                            -- nCOMPANY
  T.CRN,                                -- nCRN
  T.JUR_PERS,                           -- nJUR_PERS
  J.CODE,                               -- sJUR_PERS_CODE
  T.KIPINTTYP,                          -- nKIPINTTYP
  K.CODE,                               -- sKIPINTTYP_CODE
  T.CODE,                               -- sCODE
  T.NAME,                               -- sNAME
  T.WORK_MODE,                          -- nWORK_MODE
  T.IS_ACTIVE,                          -- nIS_ACTIVE
  T.NOTE                                -- sNOTE
from
  KIPINTCFG T
  inner join JURPERSONS J on T.JUR_PERS = J.RN
  inner join KIPINTTYP  K on T.KIPINTTYP = K.RN
where exists (select null from V_USERPRIV UP where UP.CATALOG = T.CRN)
  and exists (select null from V_USERPRIV UP where UP.JUR_PERS = T.JUR_PERS and UP.UNITCODE = 'KiparisIntegrationConfigs');
