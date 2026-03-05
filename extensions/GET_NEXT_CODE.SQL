/* Функция возвращает следующий код для заданной таблицы и поля, основываясь на максимальном существующем значении. */
create or replace function GET_NEXT_CODE
(
  nCOMPANY                  in number,        -- Организация
  sTABLE_NAME               in varchar2,      -- Имя таблицы
  sFIELD_NAME               in varchar2
                              default 'CODE', -- Имя поля
  nSIZE                     in number
                              default 20,     -- Длина искомой строки
  sPREFIX                   in varchar2
                              default null     -- Префикс для кода (будет добавлен перед числовой частью)
) return varchar2 
as
  nVALUE                    PKG_STD.tNUMBER;
  nPREFIX_LEN               number := length(sPREFIX);
  sSQL                      PKG_STD.tSQL;
  sFIELD_NAME_              PKG_STD.tSTRING;
begin
  /* Защита: если передали NULL явно, используем 'CODE' */
  sFIELD_NAME_ := PKG_SQL_BUILD.QUOTED_NAME(nvl(sFIELD_NAME, 'CODE'));

  sSQL := PKG_SQL_BUILD.COMPATIBLE;
  /* Строим SQL-запрос для получения максимального числового значения, извлекая его из поля, которое может содержать префикс. */
  if (nPREFIX_LEN > 0) then
    PKG_SQL_BUILD.APPEND(sSQL, 'SELECT COALESCE(MAX(TRY_PARSE_NUMBER(SUBSTR(' || sFIELD_NAME_ || ',' || (nPREFIX_LEN + 1) || '), 0)), 0)');
  else
    PKG_SQL_BUILD.APPEND(sSQL, 'SELECT COALESCE(MAX(TRY_PARSE_NUMBER(' || sFIELD_NAME_ || ', 0)), 0)');
  end if;
  PKG_SQL_BUILD.APPEND(sSQL, 'FROM ' || PKG_SQL_BUILD.QUOTED_NAME(sTABLE_NAME));
  PKG_SQL_BUILD.APPEND(sSQL, 'WHERE COMPANY = ' || PKG_SQL_BUILD.VAR_NAME('COMPANY', 1));

  /* Если есть префикс, ищем только по кодам, которые начинаются с него */
  if (nPREFIX_LEN > 0) then
    PKG_SQL_BUILD.APPEND(sSQL, 'AND ' || sFIELD_NAME_ || ' LIKE ' || PKG_SQL_BUILD.VAR_NAME('PREF', 2));
  end if;

  /* Выполняем запрос и получаем максимальное числовое значение для данного префикса (или для всех кодов, если префикса нет) */
  if (nPREFIX_LEN > 0) then
    execute immediate sSQL
       into nVALUE
      using nCOMPANY, sPREFIX || '%';
  else
    execute immediate sSQL
       into nVALUE
      using nCOMPANY;
  end if;

  /* Собираем результат: ПРЕФИКС + (ЧИСЛО + 1, дополненное нулями до оставшейся длины) */
  return sPREFIX || lpad(nVALUE + 1, nSIZE - nPREFIX_LEN, '0');
end;
/
show errors function GET_NEXT_CODE;