/* Блок внешних ключей */
alter table KIPINTCFG
add
(
-- Ссылка на организации
constraint C_KIPINTCFG_COMPANY_FK foreign key (COMPANY)
  references COMPANIES(RN),
-- Ссылка на каталоги
constraint C_KIPINTCFG_CRN_FK foreign key (CRN)
  references ACATALOG(RN),
-- Ссылка на юридические лица
constraint C_KIPINTCFG_JUR_PERS_FK foreign key (JUR_PERS)
  references JURPERSONS(RN),
-- Ссылка на виды интеграций КИПАРИС
constraint C_KIPINTCFG_KIPINTTYP_FK foreign key (KIPINTTYP)
  references KIPINTTYP(RN)
);
