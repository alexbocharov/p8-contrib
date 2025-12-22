/* Триггер до исправления */
create or replace trigger T_PRECOSENDREG_BUPDATE
  before update on PRECOSENDREG for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('PRECOSENDREG', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('PRECOSENDREG', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('PRECOSENDREG', 'CREATED', :new.CREATED, :old.CREATED);

  /* установка значения поля даты модификации */
  :new.UPDATED := sysdate;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOSENDREG', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG('CODE', :new.CODE, :old.CODE);
    PKG_IUD.REG(1, 'NAME', :new.NAME, :old.NAME);
    PKG_IUD.REG('SYSTEM', :new.SYSTEM, :old.SYSTEM);
    PKG_IUD.REG('IS_ACTIVE', :new.IS_ACTIVE, :old.IS_ACTIVE);
    PKG_IUD.REG('CREATED', :new.CREATED, :old.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED, :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOSENDREG_BUPDATE;
