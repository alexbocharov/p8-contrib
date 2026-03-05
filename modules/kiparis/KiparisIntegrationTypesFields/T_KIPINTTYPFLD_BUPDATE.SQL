/* Триггер до исправления */
create or replace trigger T_KIPINTTYPFLD_BUPDATE
  before update on KIPINTTYPFLD for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('KIPINTTYPFLD', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('KIPINTTYPFLD', 'PRN', :new.PRN, :old.PRN);

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTTYPFLD', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_PRN('PRN', :new.PRN, :old.PRN);
    PKG_IUD.REG(1, 'FLD_CODE', :new.FLD_CODE, :old.FLD_CODE);
    PKG_IUD.REG('FLD_NAME', :new.FLD_NAME, :old.FLD_NAME);
    PKG_IUD.REG('SORT_ORDER', :new.SORT_ORDER, :old.SORT_ORDER);
    PKG_IUD.REG('ENTRY_TYPE', :new.ENTRY_TYPE, :old.ENTRY_TYPE);
    PKG_IUD.REG('DATA_TYPE', :new.DATA_TYPE, :old.DATA_TYPE);
    PKG_IUD.REG('STPOLICY', :new.STPOLICY, :old.STPOLICY);
    PKG_IUD.REG('BUNDLE', :new.BUNDLE, :old.BUNDLE);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTTYPFLD_BUPDATE;
