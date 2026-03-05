/* Кипарис. Виды интеграций */
create table KIPINTTYP
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Код */
CODE              varchar2( 30 ) not null
                  constraint C_KIPINTTYP_CODE_NB check( rtrim(CODE) is not null ),
/* Наименование */
NAME              varchar2( 160 ) not null
                  constraint C_KIPINTTYP_NAME_NB check( rtrim(NAME) is not null ),
/* ключи */
constraint C_KIPINTTYP_PK primary key (RN),
constraint C_KIPINTTYP_UK unique (CODE)
);
