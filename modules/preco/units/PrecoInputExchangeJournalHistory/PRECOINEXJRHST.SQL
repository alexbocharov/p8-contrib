/* ПРЕКО. Платформа сбора первичной отчётности. Журнал входящего обмена отчётностью (история) */
create table PRECOINEXJRHST
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Родитель */
PRN               number( 17 ) not null,
/* Порядковый номер */
NUMB              number( 17 ) not null
                  constraint C_PRECOINEXJRHST_NUMB_NB check( rtrim(NUMB) is not null ),
/* Идентификатор сообщения */
MSG_ID            varchar2( 36 ) not null
                  constraint C_PRECOINEXJRHST_MSG_ID_NB check( rtrim(MSG_ID) is not null ),
/* Статус */
STATUS            varchar2( 20 ) not null
                  constraint C_PRECOINEXJRHST_STATUS_NB check( rtrim(STATUS) is not null ),
/* Код ошибки */
ERR_CODE          varchar2( 20 ) default null
                  constraint C_PRECOINEXJRHST_ERR_CODE_NB check( ERR_CODE is null or rtrim(ERR_CODE) is not null ),
/* Текст ошибки */
ERR_TEXT          varchar2( 4000 ) default null
                  constraint C_PRECOINEXJRHST_ERR_TEXT_NB check( ERR_TEXT is null or rtrim(ERR_TEXT) is not null ),
/* Дата создания */
CREATED           date not null,
/* Дата модификации */
UPDATED           date not null,
/* ключи */
constraint C_PRECOINEXJRHST_PK primary key (RN),
constraint C_PRECOINEXJRHST_MSG_ID_UK unique (MSG_ID),
constraint C_PRECOINEXJRHST_NUMB_UK unique (NUMB)
);
