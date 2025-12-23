/* Триггер до добавления */
create or replace trigger T_PRECODIRCTRMAP_BINSERT
  before insert on PRECODIRCTRMAP for each row
declare
  dCURRENT_DATE             date;
begin
  /* установка значений полей даты создания и модификации */
  dCURRENT_DATE := sysdate;

  :new.CREATED := coalesce( :new.CREATED,dCURRENT_DATE );
  :new.UPDATED := dCURRENT_DATE;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECODIRCTRMAP', 'I') ) then
    PKG_IUD.REG_RN('RN', :new.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY);
    PKG_IUD.REG('CRN', :new.CRN);
    PKG_IUD.REG(1, 'AGENT', :new.AGENT);
    PKG_IUD.REG_CRN('BLREPCRN', :new.BLREPCRN);
    PKG_IUD.REG('CREATED', :new.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECODIRCTRMAP_BINSERT;
