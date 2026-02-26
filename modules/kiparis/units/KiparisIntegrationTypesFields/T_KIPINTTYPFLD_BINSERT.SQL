/* Триггер до добавления */
create or replace trigger T_KIPINTTYPFLD_BINSERT
  before insert on KIPINTTYPFLD for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTTYPFLD', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_PRN('PRN', :new.PRN);
    PKG_IUD.REG(1, 'FLD_CODE', :new.FLD_CODE);
    PKG_IUD.REG('FLD_NAME', :new.FLD_NAME);
    PKG_IUD.REG('ENTRY_TYPE', :new.ENTRY_TYPE);
    PKG_IUD.REG('DATA_TYPE', :new.DATA_TYPE);
    PKG_IUD.REG('STPOLICY', :new.STPOLICY);
    PKG_IUD.REG('BUNDLE', :new.BUNDLE);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTTYPFLD_BINSERT;
