/* Клиентская процедура для формы редактирования раздела "Кипарис. Настройки интеграций" */  
create or replace procedure P_KIPINTCFG_FORM_EDIT
(
  nCOMPANY                  in number,       -- Организация
  nACTION                   in number,       -- Действие (0 - добавление, 1 - исправление, 2 - размножение)
  sCODE                     in out varchar2  -- Мнемокод
)
as
begin
  if sCODE is null or nACTION = 2 then
    P_KIPINTCFG_GETNEXTCODE(nCOMPANY, sCODE);
  end if;
end;
/
show errors procedure P_KIPINTCFG_FORM_EDIT;