/* Триггер до удаления */
create or replace trigger T_KIPINTTYP_BDELETE
  before delete on KIPINTTYP for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTTYP', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG(1, 'CODE', :old.CODE);
    PKG_IUD.REG('NAME', :old.NAME);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTTYP_BDELETE;
