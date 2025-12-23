/* ПРЕКО. Платформа сбора первичной отчётности. Сопоставление каталогов загрузки и контрагентов */
create or replace view V_PRECODIRCTRMAP
(
  nRN,                                  -- Регистрационный номер
  nCOMPANY,                             -- Организация
  nCRN,                                 -- Каталог
  nAGENT,                               -- Ссылка на контрагента
  sAGNLIST_AGNABBR,                     -- Мнемокод контрагента
  sAGNLIST_AGNNAME,                     -- Наименование контрагента
  sAGNLIST_AGNIDNUMB,                   -- ИНН контрагента
  sAGNLIST_REASON_CODE,                 -- КПП контрагента
  nBLREPCRN,                            -- Ссылка на каталог (Первичные\Сводные отчеты)
  sBLREPCRN_NAME,                       -- Каталог загрузки
  dCREATED,                             -- Дата создания
  dUPDATED                              -- Дата модификации
)
as
select
  T.RN,                                 -- nRN
  T.COMPANY,                            -- nCOMPANY
  T.CRN,                                -- nCRN
  T.AGENT,                              -- nAGENT
  AGN.AGNABBR,                          -- sAGNLIST_AGNABBR
  AGN.AGNNAME,                          -- sAGNLIST_AGNNAME
  AGN.AGNIDNUMB,                        -- sAGNLIST_AGNIDNUMB
  AGN.REASON_CODE,                      -- sAGNLIST_REASON_CODE
  T.BLREPCRN,                           -- nBLREPCRN
  C.NAME,                               -- sBLREPCRN_NAME
  T.CREATED,                            -- dCREATED
  T.UPDATED                             -- dUPDATED
from
  PRECODIRCTRMAP T
  inner join AGNLIST  AGN on T.AGENT = AGN.RN
  inner join ACATALOG C   on T.BLREPCRN = C.RN
where exists (select null from V_USERPRIV UP where UP.CATALOG = T.CRN);
