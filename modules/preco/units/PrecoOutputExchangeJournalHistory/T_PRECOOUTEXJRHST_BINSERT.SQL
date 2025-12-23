/* Триггер до добавления */
create or replace trigger T_PRECOOUTEXJRHST_BINSERT
  before insert on PRECOOUTEXJRHST for each row
declare
  dCURRENT_DATE             date;
begin
  /* считывание параметров записи master-таблицы */
  select COMPANY,CRN,JUR_PERS
    into :new.COMPANY,:new.CRN,:new.JUR_PERS
    from PRECOOUTEXJR
   where RN = :new.PRN;

  /* установка значений полей даты создания и модификации */
  dCURRENT_DATE := sysdate;
  :new.CREATED := coalesce( :new.CREATED,dCURRENT_DATE );
  :new.UPDATED := dCURRENT_DATE;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOOUTEXJRHST', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN);
    PKG_IUD.REG_PRN('PRN', :new.PRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :new.JUR_PERS);
    PKG_IUD.REG(1, 'NUMB', :new.NUMB);
    PKG_IUD.REG('MSG_ID', :new.MSG_ID);
    PKG_IUD.REG('AUTHID', :new.AUTHID);
    PKG_IUD.REG('STATUS', :new.STATUS);
    PKG_IUD.REG('ERR_CODE', :new.ERR_CODE);
    PKG_IUD.REG('ERR_TEXT', :new.ERR_TEXT);
    PKG_IUD.REG('CREATED', :new.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOOUTEXJRHST_BINSERT;
