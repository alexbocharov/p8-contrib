/* Блок внешних ключей */
alter table PRECOOUTEXJRHST
add
(
-- Ссылка на организации
constraint C_PRECOOUTEXJRHST_COMPANY_FK foreign key (COMPANY)
  references COMPANIES(RN),
-- Ссылка на каталоги
constraint C_PRECOOUTEXJRHST_CRN_FK foreign key (CRN)
  references ACATALOG(RN),
-- Ссылка на юридические лица
constraint C_PRECOOUTEXJRHST_JUR_PERS_FK foreign key (JUR_PERS)
  references JURPERSONS(RN),
-- Ссылка на родителя
constraint C_PRECOOUTEXJRHST_PRN_FK foreign key (PRN)
  references PRECOOUTEXJR(RN) on delete cascade
);
