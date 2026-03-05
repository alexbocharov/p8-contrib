/* Блок внешних ключей */
alter table KIPINTCFGVAL
add
(
-- Ссылка на организации
constraint C_KIPINTCFGVAL_COMPANY_FK foreign key (COMPANY)
  references COMPANIES(RN),
-- Ссылка на каталоги
constraint C_KIPINTCFGVAL_CRN_FK foreign key (CRN)
  references ACATALOG(RN),
-- Ссылка на юридические лица
constraint C_KIPINTCFGVAL_JUR_PERS_FK foreign key (JUR_PERS)
  references JURPERSONS(RN),
-- Ссылка на параметры вида интеграции
constraint C_KIPINTCFGVAL_KIPINTTYPFLD_FK foreign key (KIPINTTYPFLD)
  references KIPINTTYPFLD(RN) on delete cascade,
-- Ссылка на родителя
constraint C_KIPINTCFGVAL_PRN_FK foreign key (PRN)
  references KIPINTCFG(RN) on delete cascade
);
