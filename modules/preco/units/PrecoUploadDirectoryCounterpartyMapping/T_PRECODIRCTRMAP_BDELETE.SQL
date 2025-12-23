/* Триггер до удаления */
create or replace trigger T_PRECODIRCTRMAP_BDELETE
  before delete on PRECODIRCTRMAP for each row
begin
  /* регистрация события */
  if ( PKG_IUD.PROLOGUE('PRECODIRCTRMAP', 'D') ) then
    PKG_IUD.REG_RN('RN', :old.RN);
    PKG_IUD.REG_COMPANY('COMPANY', :old.COMPANY);
    PKG_IUD.REG('CRN', :old.CRN);
    PKG_IUD.REG(1, 'AGENT', :old.AGENT);
    PKG_IUD.REG_CRN('BLREPCRN', :old.BLREPCRN);
    PKG_IUD.REG('CREATED', :old.CREATED);
    PKG_IUD.REG('UPDATED', :old.UPDATED);
    PKG_IUD.EPILOGUE;
  end if;
end;
/
show errors trigger T_PRECODIRCTRMAP_BDELETE;
