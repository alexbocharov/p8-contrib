/* Генерация порядкового номера */
create or replace procedure P_PRECOOUTEXJRHST_GETNEXTNUMB
(
  nCOMPANY                  in number,       -- Организация
  nPRN                      in number,       -- Родитель
  nNUMB                     out number       -- Порядковый номер
)
as
begin
  /* поиск максимального */
  begin
    select max(NUMB)
      into nNUMB
      from PRECOOUTEXJRHST
     where COMPANY = nCOMPANY
       and PRN = nPRN;
  exception
    when NO_DATA_FOUND then
      nNUMB := 0;
  end;

  /* генерация */
  nNUMB := nNUMB + 1;
end;
/
show errors procedure P_PRECOOUTEXJRHST_GETNEXTNUMB;