/* Триггер до исправления */
create or replace trigger T_PRECOINEXJR_BUPDATE
  before update on PRECOINEXJR for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('PRECOINEXJR', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('PRECOINEXJR', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('PRECOINEXJR', 'CREATED', :new.CREATED, :old.CREATED);

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOINEXJR', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG(1, 'AGENT', :new.AGENT, :old.AGENT);
    PKG_IUD.REG(2, 'REPORT_CODE', :new.REPORT_CODE, :old.REPORT_CODE);
    PKG_IUD.REG(3, 'REPORT_DATE', :new.REPORT_DATE, :old.REPORT_DATE);
    PKG_IUD.REG('ID', :new.ID, :old.ID);
    PKG_IUD.REG('PRECOSENDREG', :new.PRECOSENDREG, :old.PRECOSENDREG);
    PKG_IUD.REG('CONTENT', :new.CONTENT, :old.CONTENT);
    PKG_IUD.REG('STATUS', :new.STATUS, :old.STATUS);
    PKG_IUD.REG('CREATED', :new.CREATED, :old.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED, :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOINEXJR_BUPDATE;
