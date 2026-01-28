/* Триггер до добавления */
create or replace trigger T_PRECOINEXJR_BINSERT
  before insert on PRECOINEXJR for each row
declare
  dCURRENT_DATE             date;
begin
  /* установка значений полей даты создания и модификации */
  dCURRENT_DATE := sysdate;
  :new.CREATED := coalesce( :new.CREATED,dCURRENT_DATE );
  :new.UPDATED := dCURRENT_DATE;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOINEXJR', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN);
    PKG_IUD.REG(1, 'AGENT', :new.AGENT);
    PKG_IUD.REG(2, 'REPORT_CODE', :new.REPORT_CODE);
    PKG_IUD.REG(3, 'REPORT_DATE', :new.REPORT_DATE);
    PKG_IUD.REG('ID', :new.ID);
    PKG_IUD.REG('PRECOSENDREG', :new.PRECOSENDREG);
    PKG_IUD.REG('CONTENT', :new.CONTENT);
    PKG_IUD.REG('STATUS', :new.STATUS);
    PKG_IUD.REG('CREATED', :new.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOINEXJR_BINSERT;
