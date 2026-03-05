/* Поиск регистрационного номера "Кипарис. Виды интеграций (Поля)" */
create or replace procedure FIND_KIPINTTYPFLD_CODE
(
  nFLAG_SMART               in number,       -- признак генерации исключения (0 - да, 1 - нет)
  nKIPINTTYP                in number,       -- регистрационный номер профиля системы интеграции
	sFLD_CODE									in varchar2,     -- код параметра
	nRN                       out number       -- регистрационный номер
)
as
begin
  /* поиск записи */
  begin
    select RN
      into nRN
      from KIPINTTYPFLD
     where PRN = nKIPINTTYP
       and FLD_CODE = sFLD_CODE;
  exception
    when NO_DATA_FOUND then
      P_EXCEPTION( nFLAG_SMART, 'Параметр профиля системы интеграции с кодом ' || sFLD_CODE || ' не найден.' );
  end;
end;
/
show errors procedure FIND_KIPINTTYPFLD_CODE;