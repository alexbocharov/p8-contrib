/* Триггер до исправления */
create or replace trigger T_PRECOOUTEXJR_BUPDATE
  before update on PRECOOUTEXJR for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('PRECOOUTEXJR', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('PRECOOUTEXJR', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('PRECOOUTEXJR', 'JUR_PERS', :new.JUR_PERS, :old.JUR_PERS);
  PKG_UNCHANGE.CHECK_NE('PRECOOUTEXJR', 'CREATED', :new.CREATED, :old.CREATED);

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOOUTEXJR', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :new.JUR_PERS, :old.JUR_PERS);
    PKG_IUD.REG(1, 'REPORT_CODE', :new.REPORT_CODE, :old.REPORT_CODE);
    PKG_IUD.REG(2, 'REPORT_DATE', :new.REPORT_DATE, :old.REPORT_DATE);
    PKG_IUD.REG('REPORT_NAME', :new.REPORT_NAME, :old.REPORT_NAME);
    PKG_IUD.REG('MSG_ID', :new.MSG_ID, :old.MSG_ID);
    PKG_IUD.REG('SENDER_CODE', :new.SENDER_CODE, :old.SENDER_CODE);
    PKG_IUD.REG('CONTENT', :new.CONTENT, :old.CONTENT);
    PKG_IUD.REG('STATUS', :new.STATUS, :old.STATUS);
    PKG_IUD.REG('CREATED', :new.CREATED, :old.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED, :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOOUTEXJR_BUPDATE;
