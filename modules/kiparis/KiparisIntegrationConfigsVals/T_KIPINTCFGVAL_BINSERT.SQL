/* Триггер до добавления */
create or replace trigger T_KIPINTCFGVAL_BINSERT
  before insert on KIPINTCFGVAL for each row
begin
  /* считывание параметров записи master-таблицы */
  select COMPANY,CRN,JUR_PERS
    into :new.COMPANY,:new.CRN,:new.JUR_PERS
    from KIPINTCFG
   where RN = :new.PRN;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('KIPINTCFGVAL', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG_PRN('PRN', :new.PRN);
    PKG_IUD.REG_CRN('CRN', :new.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :new.JUR_PERS);
    PKG_IUD.REG(1, 'KIPINTTYPFLD', :new.KIPINTTYPFLD);
    PKG_IUD.REG('VAL_STR', :new.VAL_STR);
    PKG_IUD.REG('VAL_NUM', :new.VAL_NUM);
    PKG_IUD.REG('VAL_DATE', :new.VAL_DATE);
    PKG_IUD.REG('VAL_REF', :new.VAL_REF);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_KIPINTCFGVAL_BINSERT;
