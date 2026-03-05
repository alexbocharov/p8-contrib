/* Базовое исправление */
create or replace procedure P_KIPINTTYP_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  sCODE                     in varchar2,     -- Код
  sNAME                     in varchar2      -- Наименование
)
as
begin
  /* исправление записи в таблице */
  update KIPINTTYP
     set CODE = sCODE,
         NAME = sNAME
   where RN = nRN;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationTypes' );
  end if;
end;
/
show errors procedure P_KIPINTTYP_BASE_UPDATE;
