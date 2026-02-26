/* Триггер до добавления */
create or replace trigger T_KIPINTTYP_BINSERT
  before insert on KIPINTTYP for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTTYP', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG(1, 'CODE', :new.CODE);
    PKG_IUD.REG('NAME', :new.NAME);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTTYP_BINSERT;
