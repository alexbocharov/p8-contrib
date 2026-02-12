create or replace package KIP_SENTRY
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
end KIP_SENTRY;
/
show errors package KIP_SENTRY;