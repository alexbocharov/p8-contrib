/* ПРЕКО. Платформа сбора первичной отчётности. Журнал исходящего обмена отчётностью */
create or replace view V_PRECOOUTEXJRHST
(
  nRN,                                  -- Регистрационный номер
  nCOMPANY,                             -- Организация
  nCRN,                                 -- Каталог
  nPRN,                                 -- Родитель
  nJUR_PERS,                            -- Ссылка на юридическое лицо
  nNUMB,                                -- Порядковый номер
  sID,                                  -- Идентификатор экземпляра отчёта
  sAUTHID,                              -- Пользователь
  sSTATUS,                              -- Статус
  sERR_CODE,                            -- Код ошибки
  sERR_TEXT,                            -- Текст ошибки
  dCREATED,                             -- Дата создания
  dUPDATED                              -- Дата модификации
)
as
select
  T.RN,                                 -- nRN
  T.COMPANY,                            -- nCOMPANY
  T.CRN,                                -- nCRN
  T.PRN,                                -- nPRN
  T.JUR_PERS,                           -- nJUR_PERS
  T.NUMB,                               -- nNUMB
  T.ID,                                 -- sID
  T.AUTHID,                             -- sAUTHID
  T.STATUS,                             -- sSTATUS
  T.ERR_CODE,                           -- sERR_CODE
  T.ERR_TEXT,                           -- sERR_TEXT
  T.CREATED,                            -- dCREATED
  T.UPDATED                             -- dUPDATED
from
  PRECOOUTEXJRHST T
where exists (select null from V_USERPRIV UP where UP.CATALOG = T.CRN)
  and exists (select null from V_USERPRIV UP where UP.JUR_PERS = T.JUR_PERS and UP.UNITCODE = 'PrecoOutputExchangeJournal');
