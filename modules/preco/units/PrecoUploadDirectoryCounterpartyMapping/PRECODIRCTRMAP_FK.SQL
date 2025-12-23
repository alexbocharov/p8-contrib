/* Блок внешних ключей */
alter table PRECODIRCTRMAP
add
(
-- Ссылка на каталоги (Первичные\Сводные отчеты)
constraint C_PRECODIRCTRMAP_BLREPCRN_FK foreign key (BLREPCRN)
  references ACATALOG(RN),
-- Ссылка на контрагенты
constraint C_PRECODIRCTRMAP_AGENT_FK foreign key (AGENT)
  references AGNLIST(RN),
-- Ссылка на организации
constraint C_PRECODIRCTRMAP_COMPANY_FK foreign key (COMPANY)
  references COMPANIES(RN),
-- Ссылка на каталоги
constraint C_PRECODIRCTRMAP_CRN_FK foreign key (CRN)
  references ACATALOG(RN)
);
