/* Клиентская процедура для формы редактирования раздела "Кипарис. Настройки интеграций" */  
create or replace procedure P_KIPINTCFG_FORM_EDIT
(
  nCOMPANY                  in number,       -- Организация
  sKIPINTTYP_CODE           in varchar2,     -- Код вида интеграции КИПАРИС
  sKIPINTTYP_NAME           out varchar2     -- Вид интеграции КИПАРИС
)
as
begin
  begin
    select T.NAME
      into sKIPINTTYP_NAME
      from KIPINTTYP T
     where T.CODE = sKIPINTTYP_CODE;
  exception
    when NO_DATA_FOUND then
      sKIPINTTYP_NAME := null;
  end;
end;
/
show errors procedure P_KIPINTCFG_FORM_EDIT;