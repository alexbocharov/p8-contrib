/* Базовое исправление */
create or replace procedure P_KIPINTCFGVAL_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nKIPINTTYPFLD             in number        -- Ссылка на параметр вида интеграции
)
as
begin
  /* исправление записи в таблице */
  update KIPINTCFGVAL
     set KIPINTTYPFLD = nKIPINTTYPFLD
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationConfigsVals' );
  end if;
end;
/
show errors procedure P_KIPINTCFGVAL_BASE_UPDATE;
