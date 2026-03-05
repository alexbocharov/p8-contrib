/* Кипарис. Настройки интеграций (Параметры) */
create table KIPINTCFGVAL
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Родитель */
PRN               number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Ссылка на юридическое лицо */
JUR_PERS          number( 17 ) not null,
/* Ссылка на параметр вида интеграции */
KIPINTTYPFLD      number( 17 ) not null,
/* Значение: строка */
VAL_STR           varchar2( 4000 ) default null
                  constraint C_KIPINTCFGVAL_VAL_STR_NB check( VAL_STR is null or rtrim(VAL_STR) is not null ),
/* Значение: число */
VAL_NUM           number( 17,5 ) default null,
/* Значение: дата */
VAL_DATE          date default null,
/* Значение: Ссылка на Vault (хранилище секретов) */
VAL_REF           varchar2( 240 ) default null
                  constraint C_KIPINTCFGVAL_VAL_REF_NB check( VAL_REF is null or rtrim(VAL_REF) is not null ),
/* ключи */
constraint C_KIPINTCFGVAL_PK primary key (RN),
constraint C_KIPINTCFGVAL_UK unique (PRN,KIPINTTYPFLD)
);
