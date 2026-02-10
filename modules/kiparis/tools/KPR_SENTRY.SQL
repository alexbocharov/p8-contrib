create or replace package KPR_SENTRY
as
  /* Защитить данные от несанкционированного доступа */
  function GUARD
  (
    nRN                     in number,    -- Регистрационный номер
    sDATA                   in varchar2   -- Данные для защиты
  )
  return raw;

  /* Раскрыть данные для авторизованного доступа */
  function REVEAL
  (
    nRN                     in number,    -- Регистрационный номер
    rSECURED_DATA           in raw        -- Защищённые данные
  )
  return varchar2;
end KPR_SENTRY;
/
show errors package KPR_SENTRY;