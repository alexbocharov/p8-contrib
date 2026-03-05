/* Триггер до удаления */
create or replace trigger T_KIPINTCFGVAL_BDELETE
  before delete on KIPINTCFGVAL for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTCFGVAL', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG_PRN('PRN', :old.PRN);
    PKG_IUD.REG_CRN('CRN', :old.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :old.JUR_PERS);
    PKG_IUD.REG(1, 'KIPINTTYPFLD', :old.KIPINTTYPFLD);
    PKG_IUD.REG('VAL_STR', :old.VAL_STR);
    PKG_IUD.REG('VAL_NUM', :old.VAL_NUM);
    PKG_IUD.REG('VAL_DATE', :old.VAL_DATE);
    PKG_IUD.REG('VAL_REF', :old.VAL_REF);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTCFGVAL_BDELETE;
