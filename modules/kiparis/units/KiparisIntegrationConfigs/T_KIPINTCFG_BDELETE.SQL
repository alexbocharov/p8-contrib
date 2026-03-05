/* Триггер до удаления */
create or replace trigger T_KIPINTCFG_BDELETE
  before delete on KIPINTCFG for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTCFG', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :old.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :old.JUR_PERS);
    PKG_IUD.REG(1, 'KIPINTTYP', :old.KIPINTTYP);
    PKG_IUD.REG(2, 'CODE', :old.CODE);
    PKG_IUD.REG('NAME', :old.NAME);
    PKG_IUD.REG('WORK_MODE', :old.WORK_MODE);
    PKG_IUD.REG('IS_ACTIVE', :old.IS_ACTIVE);
    PKG_IUD.REG('NOTE', :old.NOTE);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTCFG_BDELETE;
