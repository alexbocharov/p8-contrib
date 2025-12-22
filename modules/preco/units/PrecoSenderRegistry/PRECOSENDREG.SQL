/* ПРЕКО. Платформа сбора первичной отчётности. Реестр отправителей */
create table PRECOSENDREG
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Код */
CODE              varchar2( 36 ) not null
                  constraint C_PRECOSENDREG_CODE_NB check( rtrim(CODE) is not null ),
/* Наименование */
NAME              varchar2( 160 ) not null
                  constraint C_PRECOSENDREG_NAME_NB check( rtrim(NAME) is not null ),
/* Система */
SYSTEM            number( 1 ) not null
                  constraint C_PRECOSENDREG_SYSTEM_VAL check( SYSTEM in (0,1) ),
/* Активен */
IS_ACTIVE         number( 1 ) default 1 not null
                  constraint C_PRECOSENDREG_IS_ACTIVE_VAL check( IS_ACTIVE in (0,1) ),
/* Дата создания */
CREATED           date not null,
/* Дата модификации */
UPDATED           date not null,
/* ключи */
constraint C_PRECOSENDREG_PK primary key (RN),
constraint C_PRECOSENDREG_CODE_UK unique (COMPANY,CODE),
constraint C_PRECOSENDREG_NAME_UK unique (COMPANY,NAME)
);
