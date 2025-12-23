/* Базовое добавление */
create or replace procedure P_PRECODIRCTRMAP_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  nAGENT                    in number,       -- Ссылка на контрагента
  nBLREPCRN                 in number,       -- Ссылка на каталог (Первичные\Сводные отчеты)
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into PRECODIRCTRMAP
  (
    RN,
    COMPANY,
    CRN,
    AGENT,
    BLREPCRN
  )
  values
  (
    nRN,
    nCOMPANY,
    nCRN,
    nAGENT,
    nBLREPCRN
  );
end;
/
show errors procedure P_PRECODIRCTRMAP_BASE_INSERT;
