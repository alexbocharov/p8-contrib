/* Триггер до исправления */
create or replace trigger T_KIPINTCFG_BUPDATE
  before update on KIPINTCFG for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('KIPINTCFG', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('KIPINTCFG', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('KIPINTCFG', 'JUR_PERS', :new.JUR_PERS, :old.JUR_PERS);

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTCFG', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :new.JUR_PERS, :old.JUR_PERS);
    PKG_IUD.REG(1, 'KIPINTTYP', :new.KIPINTTYP, :old.KIPINTTYP);
    PKG_IUD.REG(2, 'CODE', :new.CODE, :old.CODE);
    PKG_IUD.REG('NAME', :new.NAME, :old.NAME);
    PKG_IUD.REG('WORK_MODE', :new.WORK_MODE, :old.WORK_MODE);
    PKG_IUD.REG('IS_ACTIVE', :new.IS_ACTIVE, :old.IS_ACTIVE);
    PKG_IUD.REG('NOTE', :new.NOTE, :old.NOTE);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTCFG_BUPDATE;
