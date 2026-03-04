/* Считывание записи */
create or replace procedure P_KIPINTCFG_EXISTS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  rKIPINTCFG                out KIPINTCFG%rowtype -- запись настройки интеграции
)
as
begin
  /* поиск записи */
  begin
    select *
      into rKIPINTCFG
      from KIPINTCFG
     where RN = nRN
       and COMPANY = nCOMPANY;
  exception
    when NO_DATA_FOUND then
      PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationConfigs' );
  end;
end;
/
show errors procedure P_KIPINTCFG_EXISTS;
