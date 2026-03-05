/* Разрешение ссылок */
create or replace procedure P_KIPINTCFG_JOINS
(
  nCOMPANY                  in number,       -- Регистрационный номер организации
  sJUR_PERS_CODE            in varchar2,     -- Принадлежность
  sKIPINTTYP_CODE           in varchar2,     -- Код
  nJUR_PERS                 out number,      -- Ссылка на юридическое лицо
  nKIPINTTYP                out number       -- Ссылка на вид интеграций КИПАРИС
)
as
begin
  /* Поиск юридического лица */
  FIND_JURPERSONS_CODE(0, 0, nCOMPANY, sJUR_PERS_CODE, nJUR_PERS);
  /* Поиск вида интеграций КИПАРИС */
  FIND_KIPINTTYP_CODE(0, sKIPINTTYP_CODE, nKIPINTTYP);
end;
/
show errors procedure P_KIPINTCFG_JOINS;
