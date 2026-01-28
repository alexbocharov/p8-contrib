/* Триггер до удаления */
create or replace trigger T_PRECOINEXJR_BDELETE
  before delete on PRECOINEXJR for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOINEXJR', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG_CRN('CRN', :old.CRN);
    PKG_IUD.REG(1, 'AGENT', :old.AGENT);
    PKG_IUD.REG(2, 'REPORT_CODE', :old.REPORT_CODE);
    PKG_IUD.REG(3, 'REPORT_DATE', :old.REPORT_DATE);
    PKG_IUD.REG('ID', :old.ID);
    PKG_IUD.REG('PRECOSENDREG', :old.PRECOSENDREG);
    PKG_IUD.REG('CONTENT', :old.CONTENT);
    PKG_IUD.REG('STATUS', :old.STATUS);
    PKG_IUD.REG('CREATED', :old.CREATED);
    PKG_IUD.REG('UPDATED', :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOINEXJR_BDELETE;
