/* Базовое исправление */
create or replace procedure P_KIPINTTYPFLD_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nPRN                      in number,       -- Родитель
  sFLD_CODE                 in varchar2,     -- Код параметра
  sFLD_NAME                 in varchar2,     -- Наименование параметра
  nENTRY_TYPE               in number,       -- Способ формирования
  nDATA_TYPE                in number,       -- Тип данных
  nSTPOLICY                 in number,       -- Политика хранения
  sBUNDLE                   in varchar2      -- Группа для объединения в один секрет
)
as
begin
  /* исправление записи в таблице */
  update KIPINTTYPFLD
     set PRN = nPRN,
         FLD_CODE = sFLD_CODE,
         FLD_NAME = sFLD_NAME,
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
