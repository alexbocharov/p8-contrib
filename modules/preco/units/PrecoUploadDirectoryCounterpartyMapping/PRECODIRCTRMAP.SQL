/* ПРЕКО. Платформа сбора первичной отчётности. Сопоставление каталогов загрузки первичных/сводных отчетов и контрагентов */
create table PRECODIRCTRMAP
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Ссылка на контрагента */
AGENT             number( 17 ) not null,
/* Ссылка на каталог (Первичные\Сводные отчеты) */
BLREPCRN          number( 17 ) not null,
/* Дата создания */
CREATED           date not null,
/* Дата модификации */
UPDATED           date not null,
/* ключи */
constraint C_PRECODIRCTRMAP_PK primary key (RN),
constraint C_PRECODIRCTRMAP_UK unique (COMPANY,AGENT,BLREPCRN)
);
