/* Базовое исправление */
create or replace procedure P_PRECOSENDREG_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sCODE                     in varchar2,     -- Код
  sNAME                     in varchar2,     -- Наименование
  nSYSTEM                   in number,       -- Система
  nIS_ACTIVE                in number        -- Активен
)
as
begin
  /* исправление записи в таблице */
  update PRECOSENDREG
     set CODE = sCODE,
         NAME = sNAME,
         SYSTEM = nSYSTEM,
         IS_ACTIVE = nIS_ACTIVE
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoSenderRegistry' );
  end if;
end;
/
show errors procedure P_PRECOSENDREG_BASE_UPDATE;
