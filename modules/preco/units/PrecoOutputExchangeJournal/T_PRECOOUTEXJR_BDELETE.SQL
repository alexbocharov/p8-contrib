/* Триггер до удаления */
create or replace trigger T_PRECOOUTEXJR_BDELETE
  before delete on PRECOOUTEXJR for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOOUTEXJR', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :old.CRN);
    PKG_IUD.REG_JUR_PERS('JUR_PERS', :old.JUR_PERS);
    PKG_IUD.REG(1, 'REPORT_CODE', :old.REPORT_CODE);
    PKG_IUD.REG(2, 'REPORT_DATE', :old.REPORT_DATE);
    PKG_IUD.REG('REPORT_NAME', :old.REPORT_NAME);
    PKG_IUD.REG('MSG_ID', :old.MSG_ID);
    PKG_IUD.REG('SENDER_CODE', :old.SENDER_CODE);
    PKG_IUD.REG('CONTENT', :old.CONTENT);
    PKG_IUD.REG('STATUS', :old.STATUS);
    PKG_IUD.REG('CREATED', :old.CREATED);
    PKG_IUD.REG('UPDATED', :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOOUTEXJR_BDELETE;
