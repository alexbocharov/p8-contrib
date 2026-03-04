/* Кипарис. Настройки интеграций */
create table KIPINTCFG
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Организация */
COMPANY           number( 17 ) not null,
/* Каталог */
CRN               number( 17 ) not null,
/* Ссылка на юридическое лицо */
JUR_PERS          number( 17 ) not null,
/* Ссылка на вид интеграций КИПАРИС */
KIPINTTYP         number( 17 ) not null,
/* Активна */
IS_ACTIVE         number( 1 ) default 1 not null,
/* Примечание */
NOTE              varchar2( 2000 ) default null
                  constraint C_KIPINTCFG_NOTE_NB check( NOTE is null or rtrim(NOTE) is not null ),
/* ключи */
constraint C_KIPINTCFG_PK primary key (RN),
constraint C_KIPINTCFG_UK unique (COMPANY,JUR_PERS,KIPINTTYP)
);
