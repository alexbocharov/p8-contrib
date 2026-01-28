/* Триггер до удаления */
create or replace trigger T_PRECOINEXJRHST_BDELETE
  before delete on PRECOINEXJRHST for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOINEXJRHST', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :old.CRN);
    PKG_IUD.REG('PRN', :old.PRN);
    PKG_IUD.REG(1, 'NUMB', :old.NUMB);
    PKG_IUD.REG('ID', :old.ID);
    PKG_IUD.REG('STATUS', :old.STATUS);
    PKG_IUD.REG('ERR_CODE', :old.ERR_CODE);
    PKG_IUD.REG('ERR_TEXT', :old.ERR_TEXT);
    PKG_IUD.REG('CREATED', :old.CREATED);
    PKG_IUD.REG('UPDATED', :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOINEXJRHST_BDELETE;
