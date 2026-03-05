/* Базовое исправление */
create or replace procedure P_KIPINTCFG_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nJUR_PERS                 in number,       -- Ссылка на юридическое лицо
  nKIPINTTYP                in number,       -- Ссылка на вид интеграций КИПАРИС
  sCODE                     in varchar2,     -- Мнемокод
  sNAME                     in varchar2,     -- Наименование
  nWORK_MODE                in number,       -- Режим работы
  nIS_ACTIVE                in number,       -- Активна
  sNOTE                     in varchar2      -- Примечание
)
as
begin
  /* исправление записи в таблице */
  update KIPINTCFG
     set JUR_PERS = nJUR_PERS,
         KIPINTTYP = nKIPINTTYP,
         CODE = sCODE,
         NAME = sNAME,
         WORK_MODE = nWORK_MODE,
         IS_ACTIVE = nIS_ACTIVE,
         NOTE = sNOTE
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'KiparisIntegrationConfigs' );
  end if;
end;
/
show errors procedure P_KIPINTCFG_BASE_UPDATE;
