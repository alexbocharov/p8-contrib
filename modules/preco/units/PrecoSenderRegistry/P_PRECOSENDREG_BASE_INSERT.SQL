/* Базовое добавление */
create or replace procedure P_PRECOSENDREG_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  sCODE                     in varchar2,     -- Код
  sNAME                     in varchar2,     -- Наименование
  nSYSTEM                   in number,       -- Система
  nIS_ACTIVE                in number,       -- Активен
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into PRECOSENDREG
  (
    RN,
    COMPANY,
    CRN,
    CODE,
    NAME,
    SYSTEM,
    IS_ACTIVE
  )
  values
  (
    nRN,
    nCOMPANY,
    nCRN,
    sCODE,
    sNAME,
    nSYSTEM,
    nIS_ACTIVE
  );
end;
/
show errors procedure P_PRECOSENDREG_BASE_INSERT;
