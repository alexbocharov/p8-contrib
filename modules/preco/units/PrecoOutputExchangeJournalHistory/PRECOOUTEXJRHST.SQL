/* ПРЕКО. Платформа сбора первичной отчётности. Журнал входящего обмена отчётностью (история)•1 */
create table PRECOOUTEXJRHST
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Родитель */
PRN               number( 17 ) not null,
/* Юридическое лицо */
JUR_PERS          number( 17 ) not null,
/* Порядковый номер */
NUMB              number( 17 ) not null
                  constraint C_PRECOOUTEXJRHST_NUMB_NB check( rtrim(NUMB) is not null ),
/* Идентификатор сообщения */
MSG_ID            varchar2( 36 ) not null
                  constraint C_PRECOOUTEXJRHST_MSG_ID_NB check( rtrim(MSG_ID) is not null ),
/* Пользователь */
AUTHID            varchar2( 30 ) not null
                  constraint C_PRECOOUTEXJRHST_AUTHID_NB check( rtrim(AUTHID) is not null ),
/* Статус */
STATUS            varchar2( 20 ) not null
                  constraint C_PRECOOUTEXJRHST_STATUS_NB check( rtrim(STATUS) is not null ),
/* Код ошибки */
ERR_CODE          varchar2( 20 ) default null
                  constraint C_PRECOOUTEXJRHST_ERR_CODE_NB check( ERR_CODE is null or rtrim(ERR_CODE) is not null ),
/* Текст ошибки */
ERR_TEXT          varchar2( 4000 ) default null
                  constraint C_PRECOOUTEXJRHST_ERR_TEXT_NB check( ERR_TEXT is null or rtrim(ERR_TEXT) is not null ),
/* Дата создания */
CREATED           date not null,
/* Дата модификации */
UPDATED           date not null,
/* ключи */
constraint C_PRECOOUTEXJRHST_PK primary key (RN),
constraint C_PRECOOUTEXJRHST_MSG_ID_UK unique (MSG_ID),
constraint C_PRECOOUTEXJRHST_NUMB_UK unique (NUMB)
);
