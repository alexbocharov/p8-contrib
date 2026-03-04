/* Триггер до добавления */
create or replace trigger T_KIPINTCFG_BINSERT
  before insert on KIPINTCFG for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTCFG', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :new.JUR_PERS);
    PKG_IUD.REG(1, 'KIPINTTYP', :new.KIPINTTYP);
    PKG_IUD.REG('IS_ACTIVE', :new.IS_ACTIVE);
    PKG_IUD.REG('NOTE', :new.NOTE);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTCFG_BINSERT;
