/* Триггер до добавления */
create or replace trigger T_PRECOINEXJRHST_BINSERT
  before insert on PRECOINEXJRHST for each row
declare
  dCURRENT_DATE             date;
begin
  /* считывание параметров записи master-таблицы */
  select COMPANY,CRN
    into :new.COMPANY,:new.CRN
    from PRECOINEXJR
   where RN = :new.PRN;

  /* установка значений полей даты создания и модификации */
  dCURRENT_DATE := sysdate;
  :new.CREATED := coalesce( :new.CREATED,dCURRENT_DATE );
  :new.UPDATED := dCURRENT_DATE;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOINEXJRHST', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN);
    PKG_IUD.REG('PRN', :new.PRN);
    PKG_IUD.REG(1, 'NUMB', :new.NUMB);
    PKG_IUD.REG('ID', :new.ID);
    PKG_IUD.REG('STATUS', :new.STATUS);
    PKG_IUD.REG('ERR_CODE', :new.ERR_CODE);
    PKG_IUD.REG('ERR_TEXT', :new.ERR_TEXT);
    PKG_IUD.REG('CREATED', :new.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOINEXJRHST_BINSERT;
