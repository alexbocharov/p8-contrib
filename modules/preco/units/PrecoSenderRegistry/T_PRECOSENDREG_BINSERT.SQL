/* Триггер до добавления */
create or replace trigger T_PRECOSENDREG_BINSERT
  before insert on PRECOSENDREG for each row
declare
  dCURRENT_DATE             date;
begin
  /* установка значений полей даты создания и модификации */
  dCURRENT_DATE := sysdate;

  :new.CREATED := coalesce( :new.CREATED,dCURRENT_DATE );
  :new.UPDATED := dCURRENT_DATE;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECOSENDREG', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG_CRN('CRN', :new.CRN);
    PKG_IUD.REG('CODE', :new.CODE);
    PKG_IUD.REG(1, 'NAME', :new.NAME);
    PKG_IUD.REG('SYSTEM', :new.SYSTEM);
    PKG_IUD.REG('IS_ACTIVE', :new.IS_ACTIVE);
    PKG_IUD.REG('CREATED', :new.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECOSENDREG_BINSERT;
