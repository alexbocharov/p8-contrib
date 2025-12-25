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
  select coalesce(max(NUMB),0)
    into nNUMB
    from PRECOOUTEXJRHST
   where COMPANY = nCOMPANY
    and PRN = nPRN;

  /* генерация */
  nNUMB := nNUMB + 1;
end;
/
show errors procedure P_PRECOOUTEXJRHST_GETNEXTNUMB;