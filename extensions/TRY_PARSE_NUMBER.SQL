/* Функция пытается преобразовать строку в число. Если преобразование не удается, возвращается значение по умолчанию. */
create or replace function TRY_PARSE_NUMBER
(
  sVALUE                    in varchar2,            -- Строка, которую нужно преобразовать в число
  nDEFAULT                  in number default null  -- Значение по умолчанию
)
return number
as
  nVALUE  number;
begin
  begin
    nVALUE := to_number(sVALUE);
  exception
    when OTHERS then
      nVALUE := nDEFAULT;
  end;

  return nVALUE;
end;
/
show errors function TRY_PARSE_NUMBER;