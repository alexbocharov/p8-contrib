/* Триггер до исправления */
create or replace trigger T_KIPINTCFGVAL_BUPDATE
  before update on KIPINTCFGVAL for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('KIPINTCFGVAL', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('KIPINTCFGVAL', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('KIPINTCFGVAL', 'PRN', :new.PRN, :old.PRN);
  PKG_UNCHANGE.CHECK_NE('KIPINTCFGVAL', 'JUR_PERS', :new.JUR_PERS, :old.JUR_PERS);

  /* при изменении синхронных атрибутов заголовка триггер не активировать */
  if (CMP_NUM(:old.CRN,:new.CRN) = 0 or
      CMP_NUM(:old.JUR_PERS,:new.JUR_PERS) = 0) then
    return;
  end if;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTCFGVAL', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG_PRN('PRN', :new.PRN, :old.PRN);
    PKG_IUD.REG_CRN('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :new.JUR_PERS, :old.JUR_PERS);
    PKG_IUD.REG(1, 'KIPINTTYPFLD', :new.KIPINTTYPFLD, :old.KIPINTTYPFLD);
    PKG_IUD.REG('VAL_STR', :new.VAL_STR, :old.VAL_STR);
    PKG_IUD.REG('VAL_NUM', :new.VAL_NUM, :old.VAL_NUM);
    PKG_IUD.REG('VAL_DATE', :new.VAL_DATE, :old.VAL_DATE);
    PKG_IUD.REG('VAL_REF', :new.VAL_REF, :old.VAL_REF);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTCFGVAL_BUPDATE;
