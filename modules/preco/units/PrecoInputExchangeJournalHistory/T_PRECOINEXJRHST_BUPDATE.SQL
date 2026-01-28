/* Триггер до исправления */
create or replace trigger T_PRECOINEXJRHST_BUPDATE
  before update on PRECOINEXJRHST for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('PRECOINEXJRHST', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('PRECOINEXJRHST', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('PRECOINEXJRHST', 'CREATED', :new.CREATED, :old.CREATED);

  /* при изменении синхронных атрибутов заголовка триггер не активировать */
  if (CMP_NUM(:old.CRN,:new.CRN) = 0) then
    return;
  end if;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOINEXJRHST', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG('PRN', :new.PRN, :old.PRN);
    PKG_IUD.REG(1, 'NUMB', :new.NUMB, :old.NUMB);
    PKG_IUD.REG('ID', :new.ID, :old.ID);
    PKG_IUD.REG('STATUS', :new.STATUS, :old.STATUS);
    PKG_IUD.REG('ERR_CODE', :new.ERR_CODE, :old.ERR_CODE);
    PKG_IUD.REG('ERR_TEXT', :new.ERR_TEXT, :old.ERR_TEXT);
    PKG_IUD.REG('CREATED', :new.CREATED, :old.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED, :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOINEXJRHST_BUPDATE;
