/* Триггер до удаления */
create or replace trigger T_PRECOOUTEXJRHST_BDELETE
  before delete on PRECOOUTEXJRHST for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOOUTEXJRHST', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :old.CRN);
    PKG_IUD.REG_PRN('PRN', :old.PRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :old.JUR_PERS);
    PKG_IUD.REG(1, 'NUMB', :old.NUMB);
    PKG_IUD.REG('MSG_ID', :old.MSG_ID);
    PKG_IUD.REG('AUTHID', :old.AUTHID);
    PKG_IUD.REG('STATUS', :old.STATUS);
    PKG_IUD.REG('ERR_CODE', :old.ERR_CODE);
    PKG_IUD.REG('ERR_TEXT', :old.ERR_TEXT);
    PKG_IUD.REG('CREATED', :old.CREATED);
    PKG_IUD.REG('UPDATED', :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOOUTEXJRHST_BDELETE;
