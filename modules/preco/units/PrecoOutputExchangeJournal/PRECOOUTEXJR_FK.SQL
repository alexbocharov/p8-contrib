/* Блок внешних ключей */
alter table PRECOOUTEXJR
add
(
-- Ссылка на организации
constraint C_PRECOOUTEXJR_COMPANY_FK foreign key (COMPANY)
  references COMPANIES(RN),
-- Ссылка на каталоги
constraint C_PRECOOUTEXJR_CRN_FK foreign key (CRN)
  references ACATALOG(RN),
-- Ссылка на юридические лица
constraint C_PRECOOUTEXJR_JUR_PERS_FK foreign key (JUR_PERS)
  references JURPERSONS(RN)
);
