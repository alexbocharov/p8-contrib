/* Триггер до исправления */
create or replace trigger T_KIPINTTYP_BUPDATE
  before update on KIPINTTYP for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('KIPINTTYP', 'RN', :new.RN, :old.RN);

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTTYP', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG(1, 'CODE', :new.CODE, :old.CODE);
    PKG_IUD.REG('NAME', :new.NAME, :old.NAME);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTTYP_BUPDATE;
