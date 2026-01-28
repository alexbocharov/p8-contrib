/* ПРЕКО. Платформа сбора первичной отчётности. Журнал входящего обмена отчётностью */
create or replace view V_PRECOINEXJR
(
  nRN,                                  -- Регистрационный номер
  nCOMPANY,                             -- Организация
  nCRN,                                 -- Каталог
  nAGENT,                               -- Ссылка на контрагента
  sAGNLIST_AGNABBR,                     -- Мнемокод контрагента
  sAGNLIST_AGNNAME,                     -- Наименование контрагента
  sAGNLIST_AGNIDNUMB,                   -- ИНН контрагента
  sAGNLIST_REASON_CODE,                 -- КПП контрагента
  sREPORT_CODE,                         -- Код отчета (Форма)
  dREPORT_DATE,                         -- Дата отчета
  sID,                                  -- Идентификатор экземпляра отчёта
  nPRECOSENDREG,                        -- Ссылка на реестр отправителей
  sPRECOSENDREG_CODE,                   -- Код системы-отправителя
  sSTATUS,                              -- Статус
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
  T.REPORT_CODE,                        -- sREPORT_CODE
  T.REPORT_DATE,                        -- dREPORT_DATE
  T.ID,                                 -- sID
  T.PRECOSENDREG,                       -- nPRECOSENDREG
  P.CODE,                               -- sPRECOSENDREG_CODE
  T.STATUS,                             -- sSTATUS
  T.CREATED,                            -- dCREATED
  T.UPDATED                             -- dUPDATED
from
  PRECOINEXJR T
  inner join AGNLIST      AGN on T.AGENT = AGN.RN
  inner join PRECOSENDREG P   on T.PRECOSENDREG = P.RN
where exists (select null from V_USERPRIV UP where UP.CATALOG = T.CRN);
