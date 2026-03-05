/* Поиск регистрационного номера "Кипарис. Виды интеграций" */
create or replace procedure FIND_KIPINTTYP_CODE
(
  nFLAG_SMART               in number,       -- признак генерации исключения (0 - да, 1 - нет)
	sCODE										  in varchar2,     -- код системыы интеграции
	nRN                       out number       -- регистрационный номер
)
as
begin
  /* поиск записи */
  begin
    select RN
      into nRN
      from KIPINTTYP
     where CODE = sCODE;
  exception
    when NO_DATA_FOUND then
      P_EXCEPTION( nFLAG_SMART, 'Профиль системы интеграции с кодом ' || sCODE || ' не найден.' );
  end;
end;
/
show errors procedure FIND_KIPINTTYP_CODE;