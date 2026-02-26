/* Кипарис. Виды интеграций (Поля интеграции) */
create table KIPINTTYPFLD
(
/* Регистрационный номер */
RN                number( 17 ) not null,
/* Родитель */
PRN               number( 17 ) not null,
/* Код параметра */
FLD_CODE          varchar2( 30 ) not null
                  constraint C_KIPINTTYPFLD_FLD_CODE_NB check( rtrim(FLD_CODE) is not null ),
/* Наименование параметра */
FLD_NAME          varchar2( 2000 ) not null
                  constraint C_KIPINTTYPFLD_FLD_NAME_NB check( rtrim(FLD_NAME) is not null ),
/* Способ формирования */
ENTRY_TYPE        number( 1 ) not null,
/* Тип данных */
DATA_TYPE         number( 1 ) not null
                  constraint C_KIPINTTYPFLD_DATA_TYPE_VAL check( DATA_TYPE in (0, 1, 2) ),
/* Политика хранения */
STPOLICY          number( 1 ) not null
                  constraint C_KIPINTTYPFLD_STPOLICY_VAL check( STPOLICY in (0, 1, 2) ),
/* Группа для объединения в один секрет */
BUNDLE            varchar2( 30 ) default null
                  constraint C_KIPINTTYPFLD_BUNDLE_NB check( BUNDLE is null or rtrim(BUNDLE) is not null ),
/* ключи */
constraint C_KIPINTTYPFLD_PK primary key (RN),
constraint C_KIPINTTYPFLD_UK unique (PRN,FLD_CODE),
constraint C_KIPINTTYPFLD_ENTRY_TYPE_VAL check (ENTRY_TYPE in (0, 1, 2) and ((ENTRY_TYPE = 1 and DATA_TYPE = 0) or (ENTRY_TYPE <> 1) ))
);
