/* ПРЕКО. Платформа сбора первичной отчётности. Журнал входящего обмена отчётностью */
create table PRECOINEXJR
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Ссылка на контрагента */
AGENT             number( 17 ) not null,
/* Код отчета (Форма) */
REPORT_CODE       varchar2( 20 ) not null
                  constraint C_PRECOINEXJR_REPORT_CODE_NB check( rtrim(REPORT_CODE) is not null ),
/* Дата отчета */
REPORT_DATE       date not null,
/* Идентификатор экземпляра отчёта */
ID                varchar2( 36 ) not null
                  constraint C_PRECOINEXJR_ID_NB check( rtrim(ID) is not null ),
/* Ссылка на реестр отправителей */
PRECOSENDREG      number( 17 ) not null,
/* Содержимое */
CONTENT           blob not null,
/* Статус */
STATUS            varchar2( 20 ) not null
                  constraint C_PRECOINEXJR_STATUS_NB check( rtrim(STATUS) is not null ),
/* Дата создания */
CREATED           date not null,
/* Дата модификации */
UPDATED           date not null,
/* ключи */
constraint C_PRECOINEXJR_PK primary key (RN),
constraint C_PRECOINEXJR_ID_UK unique (ID),
constraint C_PRECOINEXJR_UK unique (AGENT,REPORT_CODE,REPORT_DATE)
);
