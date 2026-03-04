/* Базовое добавление */
create or replace procedure P_KIPINTCFGVAL_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nPRN                      in number,       -- Родитель
  nKIPINTTYPFLD             in number,       -- Ссылка на параметр вида интеграции
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into KIPINTCFGVAL
  (
    RN,
    PRN,
    KIPINTTYPFLD
  )
  values
  (
    nRN,
    nPRN,
    nKIPINTTYPFLD
  );
end;
/
show errors procedure P_KIPINTCFGVAL_BASE_INSERT;
