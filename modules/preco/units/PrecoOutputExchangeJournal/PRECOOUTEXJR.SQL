/* ПРЕКО. Платформа сбора первичной отчётности. Журнал исходящего обмена отчётностью */
create table PRECOOUTEXJR
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Ссылка на юридическое лицо */
JUR_PERS          number( 17 ) not null,
/* Код отчета (Форма) */
REPORT_CODE       varchar2( 20 ) not null
                  constraint C_PRECOOUTEXJR_REPORT_CODE_NB check( rtrim(REPORT_CODE) is not null ),
/* Дата отчета */
REPORT_DATE       date not null,
/* Наименование отчета */
REPORT_NAME       varchar2( 160 ) not null
                  constraint C_PRECOOUTEXJR_REPORT_NAME_NB check( rtrim(REPORT_NAME) is not null ),
/* Идентификатор сообщения */
MSG_ID            varchar2( 36 ) not null
                  constraint C_PRECOOUTEXJR_MSG_ID_NB check( rtrim(MSG_ID) is not null ),
/* Код системы-отправителя */
SENDER_CODE       varchar2( 36 ) not null
                  constraint C_PRECOOUTEXJR_SENDER_CODE_NB check( rtrim(SENDER_CODE) is not null ),
/* Содержимое */
CONTENT           blob not null,
/* Статус */
STATUS            varchar2( 20 ) not null
                  constraint C_PRECOOUTEXJR_STATUS_NB check( rtrim(STATUS) is not null ),
/* Дата создания */
CREATED           date not null,
/* Дата модификации */
UPDATED           date not null,
/* ключи */
constraint C_PRECOOUTEXJR_PK primary key (RN),
constraint C_PRECOOUTEXJR_MSG_ID_UK unique (MSG_ID),
constraint C_PRECOOUTEXJR_UK unique (JUR_PERS,REPORT_CODE,REPORT_DATE)
);
