/* Базовое добавление */
create or replace procedure P_KIPINTTYP_BASE_INSERT
(
  sCODE                     in varchar2,     -- Код
  sNAME                     in varchar2,     -- Наименование
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into KIPINTTYP
  (
    RN,
    CODE,
    NAME
  )
  values
  (
    nRN,
    sCODE,
    sNAME
  );
end;
/
show errors procedure P_KIPINTTYP_BASE_INSERT;
