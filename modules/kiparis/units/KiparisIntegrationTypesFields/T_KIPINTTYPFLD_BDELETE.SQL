/* Триггер до удаления */
create or replace trigger T_KIPINTTYPFLD_BDELETE
  before delete on KIPINTTYPFLD for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTTYPFLD', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG(1, 'PRN', :old.PRN);
    PKG_IUD.REG(2, 'FLD_CODE', :old.FLD_CODE);
    PKG_IUD.REG('FLD_NAME', :old.FLD_NAME);
    PKG_IUD.REG('ENTRY_TYPE', :old.ENTRY_TYPE);
    PKG_IUD.REG('DATA_TYPE', :old.DATA_TYPE);
    PKG_IUD.REG('STPOLICY', :old.STPOLICY);
    PKG_IUD.REG('BUNDLE', :old.BUNDLE);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTTYPFLD_BDELETE;
