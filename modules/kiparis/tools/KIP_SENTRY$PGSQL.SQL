/* Получить секретный ключ (SHA-256 = 32 байта) */
create or replace function KIP_SENTRY$DERIVE
(
  nRN                       numeric   -- Регистрационный номер
)
returns bytea
as
$$
declare
  -- Соль для защиты данных
  cSALT                     constant text := 'f7_9Wp_q[2Z#Lm8*Tr90-Vx!u@5kYcR1';
begin
  -- Получаем секретный ключ, используя SHA-256 от регистрационного номера и соли
  return digest(convert_to(nRN::text || cSALT, 'UTF8'), 'sha256');
end;
$$ language PLPGSQL immutable;

/* Защитить данные от несанкционированного доступа */
create or replace function KIP_SENTRY$GUARD
(
  nRN                       numeric,   -- Регистрационный номер
  sDATA                     text       -- Данные для защиты
)
returns bytea
as
$$
declare
  rIV                       bytea := gen_random_bytes(16); -- Инициализационный вектор
begin
  if sDATA is null then
    return null; -- Если данные пустые, возвращаем null
  end if;

  return rIV || encrypt_iv(
        convert_to(sDATA, 'UTF8'),      -- Данные в UTF8
        KIP_SENTRY$DERIVE(nRN),         -- Ключ (32 байта)
        rIV,                            -- Вектор
        'aes-cbc/pad:pkcs'              -- Режим шифрования
      );
end;
$$ language PLPGSQL;

/* Раскрыть данные для авторизованного доступа */
create or replace function KIP_SENTRY$REVEAL
(
  nRN                       numeric,   -- Регистрационный номер
  rSECURED_DATA             bytea      -- Защищённые данные
)
returns text
as
$$
declare
  rIV                       bytea;
  rDATA                     bytea;
begin
  -- Проверка на NULL и минимальную длину (IV 16 байт + минимум 16 байт блока AES)
  if rSECURED_DATA is null or length(rSECURED_DATA) <= 16 then
    return null;
  end if;

  rIV   := substring(rSECURED_DATA from 1 for 16);  -- Первые 16 байт - IV
  rDATA := substring(rSECURED_DATA from 17);        -- Остальные байты - зашифрованные данные

  begin
    return convert_from(
      decrypt_iv(
        rDATA,
        KIP_SENTRY$DERIVE(nRN), -- Ключ (32 байта)
        rIV,                    -- Вектор
        'aes-cbc/pad:pkcs'      -- Режим шифрования
      ), 
      'UTF8'
    );
  exception 
    when OTHERS then
      return null; -- Если ключ не подошел или данные битые
  end;
end;
$$ language PLPGSQL;