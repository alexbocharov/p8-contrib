/* Базовое исправление */
create or replace procedure P_KIPINTTYPFLD_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  sFLD_CODE                 in varchar2,     -- Код параметра
  sFLD_NAME                 in varchar2,     -- Наименование параметра
  nSORT_ORDER               in number,       -- Порядок сортировки
  nENTRY_TYPE               in number,       -- Способ формирования
  nDATA_TYPE                in number,       -- Тип данных
  nSTPOLICY                 in number,       -- Политика хранения
  sBUNDLE                   in varchar2      -- Группа для объединения в один секрет
)
as
begin
  /* исправление записи в таблице */
  update KIPINTTYPFLD
     set FLD_CODE = sFLD_CODE,
         FLD_NAME = sFLD_NAME,
         SORT_ORDER = nSORT_ORDER,
         ENTRY_TYPE = nENTRY_TYPE,
         DATA_TYPE = nDATA_TYPE,
         STPOLICY = nSTPOLICY,
         BUNDLE = sBUNDLE
   where RN = nRN;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationTypesFields' );
  end if;
end;
/
show errors procedure P_KIPINTTYPFLD_BASE_UPDATE;
