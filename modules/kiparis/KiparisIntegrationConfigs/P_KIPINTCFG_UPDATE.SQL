/* Исправление настройки интеграции */
create or replace procedure P_KIPINTCFG_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sJUR_PERS_CODE            in varchar2,     -- Принадлежность
  sKIPINTTYP_CODE           in varchar2,     -- Вид интеграции
  sCODE                     in varchar2,     -- Мнемокод
  sNAME                     in varchar2,     -- Наименование
  nWORK_MODE                in number,       -- Режим работы
  nIS_ACTIVE                in number,       -- Активна
  sNOTE                     in varchar2      -- Примечание
)
as
  nJUR_PERS                 PKG_STD.tREF;    -- Ссылка на юридическое лицо
  nKIPINTTYP                PKG_STD.tREF;    -- Ссылка на вид интеграций КИПАРИС
  rKIPINTCFG                KIPINTCFG%rowtype; -- запись настройки интеграции
begin
  /* Считывание записи */
  P_KIPINTCFG_EXISTS
  (
    nRN,
    nCOMPANY,
    rKIPINTCFG
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,rKIPINTCFG.CRN,rKIPINTCFG.JUR_PERS,null,'KiparisIntegrationConfigs','KIPINTCFG_UPDATE','KIPINTCFG',nRN );

  /* Разрешение ссылок */
  P_KIPINTCFG_JOINS
  (
    nCOMPANY,
    sJUR_PERS_CODE,
    sKIPINTTYP_CODE,
    nJUR_PERS,
    nKIPINTTYP
  );

  if CMP_NUM(nJUR_PERS, rKIPINTCFG.JUR_PERS) = 0 then
    /* проверка прав доступа к новому юридическому лицу */
    PKG_ENV.ACCESS_JURPERS( nJUR_PERS );
  end if;

  /* Базовое исправление */
  P_KIPINTCFG_BASE_UPDATE
  (
    nRN,
    nCOMPANY,
    nJUR_PERS,
    nKIPINTTYP,
    sCODE,
    sNAME,
    nWORK_MODE,
    nIS_ACTIVE,
    sNOTE
  );

  /* Синхронизация состава параметров настройки по метаданным */
  if CMP_NUM(nKIPINTTYP, rKIPINTCFG.KIPINTTYP) = 0 then
    /* Удаляем старые параметры и генерируем новый состав */
    delete from KIPINTCFGVAL where PRN = nRN;
    P_KIPINTCFGVAL_BASE_GENERATE
    (
      nCOMPANY,
      nRN,
      nKIPINTTYP
    );
  else
    /* Вызываем "умную" генерацию (добавление только недостающих полей) */
    P_KIPINTCFGVAL_BASE_SYNC
    (
      nCOMPANY,
      nRN,
      nKIPINTTYP
    );
  end if;

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,rKIPINTCFG.CRN,rKIPINTCFG.JUR_PERS,null,'KiparisIntegrationConfigs','KIPINTCFG_UPDATE','KIPINTCFG',nRN );
end;
/
show errors procedure P_KIPINTCFG_UPDATE;
