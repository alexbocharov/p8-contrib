/* Блок внешних ключей */
alter table KIPINTTYPFLD
add
(
-- Ссылка на родителя
constraint C_KIPINTTYPFLD_PRN_FK foreign key (PRN)
  references KIPINTTYP(RN) on delete cascade
);
