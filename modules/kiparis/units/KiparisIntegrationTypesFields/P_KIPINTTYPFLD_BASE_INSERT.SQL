/* Базовое добавление */
create or replace procedure P_KIPINTTYPFLD_BASE_INSERT
(
  nPRN                      in number,       -- Родитель
  sFLD_CODE                 in varchar2,     -- Код параметра
  sFLD_NAME                 in varchar2,     -- Наименование параметра
  nENTRY_TYPE               in number,       -- Способ формирования
  nDATA_TYPE                in number,       -- Тип данных
  nSTPOLICY                 in number,       -- Политика хранения
  sBUNDLE                   in varchar2,     -- Группа для объединения в один секрет
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into KIPINTTYPFLD
  (
    RN,
    PRN,
    FLD_CODE,
    FLD_NAME,
    ENTRY_TYPE,
    DATA_TYPE,
    STPOLICY,
    BUNDLE
  )
  values
  (
    nRN,
    nPRN,
    sFLD_CODE,
    sFLD_NAME,
    nENTRY_TYPE,
    nDATA_TYPE,
    nSTPOLICY,
    sBUNDLE
  );
end;
/
show errors procedure P_KIPINTTYPFLD_BASE_INSERT;
