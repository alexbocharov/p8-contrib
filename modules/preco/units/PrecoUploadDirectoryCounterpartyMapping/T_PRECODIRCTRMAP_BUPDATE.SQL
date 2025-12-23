/* Триггер до исправления */
create or replace trigger T_PRECODIRCTRMAP_BUPDATE
  before update on PRECODIRCTRMAP for each row
begin
  /* проверка неизменности значений полей */
  PKG_UNCHANGE.CHECK_NE('PRECODIRCTRMAP', 'RN', :new.RN, :old.RN);
  PKG_UNCHANGE.CHECK_NE('PRECODIRCTRMAP', 'COMPANY', :new.COMPANY, :old.COMPANY);
  PKG_UNCHANGE.CHECK_NE('PRECODIRCTRMAP', 'CREATED', :new.CREATED, :old.CREATED);

  /* установка значения поля даты модификации */
  :new.UPDATED := sysdate;

  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECODIRCTRMAP', 'U') ) then
    PKG_IUD.REG_RN('RN', :new.RN, :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :new.COMPANY, :old.COMPANY);
    PKG_IUD.REG('CRN', :new.CRN, :old.CRN);
    PKG_IUD.REG(1, 'AGENT', :new.AGENT, :old.AGENT);
    PKG_IUD.REG_CRN('BLREPCRN', :new.BLREPCRN, :old.BLREPCRN);
    PKG_IUD.REG('CREATED', :new.CREATED, :old.CREATED);
    PKG_IUD.REG('UPDATED', :new.UPDATED, :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECODIRCTRMAP_BUPDATE;
