create or replace package body KIP_SENTRY$PG
as
  /* Получить секретный ключ (SHA-256 = 32 байта) */
  function DERIVE
  (
    nRN                     in number     -- Регистрационный номер
  ) 
  return raw 
  is
  begin
    P_NECESSARY_RECREATE_VOLATILE( 'KIP_SENTRY.DERIVE' );
  end;

  /* Защитить данные от несанкционированного доступа */
  function GUARD
  (
    nRN                     in number,    -- Регистрационный номер
    sDATA                   in varchar2   -- Данные для защиты
  )
  return raw
  is
  begin
    P_NECESSARY_RECREATE_VOLATILE( 'KIP_SENTRY.GUARD' );
  end;

  /* Раскрыть данные для авторизованного доступа */
  function REVEAL
  (
    nRN                     in number,    -- Регистрационный номер
    rSECURED_DATA           in raw        -- Защищённые данные
  )
  return varchar2
  is
  begin
    P_NECESSARY_RECREATE_VOLATILE( 'KIP_SENTRY.REVEAL' );
  end;
end KIP_SENTRY$PG;
/
show errors package body KIP_SENTRY$PG;