/* Добавление/размножение настройки интеграции */
create or replace procedure P_KIPINTCFG_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  sJUR_PERS_CODE            in varchar2,     -- Принадлежность
  sKIPINTTYP_CODE           in varchar2,     -- Вид интеграции
  sCODE                     in varchar2,     -- Мнемокод
  sNAME                     in varchar2,     -- Наименование
  nWORK_MODE                in number,       -- Режим работы
  nIS_ACTIVE                in number,       -- Активна
  sNOTE                     in varchar2,     -- Примечание
  nRN                       out number       -- Регистрационный номер
)
as
  nJUR_PERS                 PKG_STD.tREF;    -- Ссылка на юридическое лицо
  nKIPINTTYP                PKG_STD.tREF;    -- Ссылка на вид интеграций КИПАРИС
begin
  /* Разрешение ссылок */
  P_KIPINTCFG_JOINS
  (
    nCOMPANY,
    sJUR_PERS_CODE,
    sKIPINTTYP_CODE,
    nJUR_PERS,
    nKIPINTTYP
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,nCRN,nJUR_PERS,null,'KiparisIntegrationConfigs','KIPINTCFG_INSERT','KIPINTCFG' );

  /* Базовое добавление */
  P_KIPINTCFG_BASE_INSERT
  (
    nCOMPANY,
    nCRN,
    nJUR_PERS,
    nKIPINTTYP,
    sCODE,
    sNAME,
    nWORK_MODE,
    nIS_ACTIVE,
    sNOTE,
    nRN
  );

  /* Генерация состава параметров настройки по метаданным */
  P_KIPINTCFGVAL_BASE_GENERATE
  (
    nCOMPANY,
    nRN,
    nKIPINTTYP
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,nCRN,nJUR_PERS,null,'KiparisIntegrationConfigs','KIPINTCFG_INSERT','KIPINTCFG',nRN );
end;
/
show errors procedure P_KIPINTCFG_INSERT;
