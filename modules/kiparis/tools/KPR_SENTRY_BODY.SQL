create or replace package body KPR_SENTRY
as
  cSALT                     constant varchar2(32) := 'f7&9Wp_q[2Z#Lm8*Tr90-Vx!u@5kYcR1'; -- Соль для защиты данных

  /* Получить секретный ключ (SHA-256 = 32 байта) */
  function GET_SECRET_KEY
  (
    nRN                     in number     -- Регистрационный номер
  ) 
  return raw 
  is
  begin
    return DBMS_CRYPTO.HASH(
             src => UTL_I18N.STRING_TO_RAW(TO_CHAR(nRN) || cSALT, 'AL32UTF8'), 
             typ => DBMS_CRYPTO.HASH_SH256
           );
  end;

  /* Защитить данные от несанкционированного доступа */
  function GUARD
  (
    nRN                     in number,    -- Регистрационный номер
    sDATA                   in varchar2   -- Данные для защиты
  )
  return raw
  is
    rIV                     raw(16) := DBMS_CRYPTO.RANDOMBYTES(16); -- Инициализационный вектор
  begin
    if sDATA is null then
      return null; -- Если данные пустые, возвращаем null
    end if;

    return UTL_RAW.CONCAT(
             rIV, -- Сохраняем IV в первых 16 байтах
             DBMS_CRYPTO.ENCRYPT(
               src => UTL_I18N.STRING_TO_RAW(sDATA, 'AL32UTF8'),
               typ => DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5,
               key => GET_SECRET_KEY(nRN),
               iv  => rIV
             )
           );
  end;

  /* Раскрыть данные для авторизованного доступа */
  function REVEAL
  (
    nRN                     in number,    -- Регистрационный номер
    rSECURED_DATA           in raw        -- Защищённые данные
  )
  return varchar2
  is
    rIV                     raw(16);
    rDATA                   raw(32767); -- RAW может быть длинным
  begin
    if rSECURED_DATA is null or UTL_RAW.LENGTH(rSECURED_DATA) <= 16 then
      return null;
    end if;

    -- ВНИМАНИЕ: Используем UTL_RAW.SUBSTR вместо обычного SUBSTR
    rIV   := UTL_RAW.SUBSTR(rSECURED_DATA, 1, 16);  -- Первые 16 байт - IV
    rDATA := UTL_RAW.SUBSTR(rSECURED_DATA, 17);     -- Остальные байты - зашифрованные данные

    return UTL_I18N.RAW_TO_CHAR(
      DBMS_CRYPTO.DECRYPT(
        src => rDATA,
        typ => DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5,
        key => GET_SECRET_KEY(nRN),
        iv  => rIV
      ), 
      'AL32UTF8'
    );
  exception
    when OTHERS then
      -- В случае ошибки (например, неправильный формат данных) возвращаем null
      return null;
  end;
end KPR_SENTRY;
/
show errors package body KPR_SENTRY;