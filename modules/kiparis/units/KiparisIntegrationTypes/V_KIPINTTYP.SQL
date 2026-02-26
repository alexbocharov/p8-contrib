/* Кипарис. Виды интеграций */
create or replace view V_KIPINTTYP
(
  nRN,                                  -- Регистрационный номер
  sCODE,                                -- Код
  sNAME                                 -- Наименование
)
as
select
  T.RN,                                 -- nRN
  T.CODE,                               -- sCODE
  T.NAME                                -- sNAME
from
  KIPINTTYP T
where exists (select null from V_USERPRIV UP where UP.UNITCODE = 'KiparisIntegrationTypes');
