/* ПРЕКО. Платформа сбора первичной отчётности. Журнал исходящего обмена отчётностью */
create or replace view V_PRECOOUTEXJR
(
  nRN,                                  -- Регистрационный номер
  nCOMPANY,                             -- Организация
  nCRN,                                 -- Каталог
  nJUR_PERS,                            -- Ссылка на юридическое лицо
  sJUR_PERS_CODE,                       -- Юридическое лицо
  sJUR_PERS_AGNNAME,                    -- Контрагент
  sJUR_PERS_AGNIDNUMB,                  -- ИНН
  sJUR_PERS_REASON_CODE,                -- КПП
  sREPORT_CODE,                         -- Код отчета (Форма)
  dREPORT_DATE,                         -- Дата отчета
  sREPORT_NAME,                         -- Наименование отчета
  sMSG_ID,                              -- Идентификатор сообщения
  sSENDER_CODE,                         -- Код системы-отправителя
  sSTATUS,                              -- Статус
  dCREATED,                             -- Дата создания
  dUPDATED                              -- Дата модификации
)
as
select
  T.RN,                                 -- nRN
  T.COMPANY,                            -- nCOMPANY
  T.CRN,                                -- nCRN
  T.JUR_PERS,                           -- nJUR_PERS
  J.CODE,                               -- sJUR_PERS_CODE
  AGN.AGNNAME,                          -- sJUR_PERS_AGNNAME
  AGN.AGNIDNUMB,                        -- sJUR_PERS_AGNIDNUMB
  AGN.REASON_CODE,                      -- sJUR_PERS_REASON_CODE
  T.REPORT_CODE,                        -- sREPORT_CODE
  T.REPORT_DATE,                        -- dREPORT_DATE
  T.REPORT_NAME,                        -- sREPORT_NAME
  T.MSG_ID,                             -- sMSG_ID
  T.SENDER_CODE,                        -- sSENDER_CODE
  T.STATUS,                             -- sSTATUS
  T.CREATED,                            -- dCREATED
  T.UPDATED                             -- dUPDATED
from
  PRECOOUTEXJR T
  inner join JURPERSONS J   on T.JUR_PERS = J.RN
  inner join AGNLIST    AGN on J.AGENT = AGN.RN
where exists (select null from V_USERPRIV UP where UP.CATALOG = T.CRN)
  and exists (select null from V_USERPRIV UP where UP.JUR_PERS = T.JUR_PERS and UP.UNITCODE = 'PrecoOutputExchangeJournal');
