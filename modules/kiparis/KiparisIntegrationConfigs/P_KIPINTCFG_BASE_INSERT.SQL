/* Базовое добавление */
create or replace procedure P_KIPINTCFG_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  nJUR_PERS                 in number,       -- Ссылка на юридическое лицо
  nKIPINTTYP                in number,       -- Ссылка на вид интеграций КИПАРИС
  sCODE                     in varchar2,     -- Мнемокод
  sNAME                     in varchar2,     -- Наименование
  nWORK_MODE                in number,       -- Режим работы
  nIS_ACTIVE                in number,       -- Активна
  sNOTE                     in varchar2,     -- Примечание
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into KIPINTCFG
  (
    RN,
    COMPANY,
    CRN,
    JUR_PERS,
    KIPINTTYP,
    CODE,
    NAME,
    WORK_MODE,
    IS_ACTIVE,
    NOTE
  )
  values
  (
    nRN,
    nCOMPANY,
    nCRN,
    nJUR_PERS,
    nKIPINTTYP,
    sCODE,
    sNAME,
    nWORK_MODE,
    nIS_ACTIVE,
    sNOTE
  );
end;
/
show errors procedure P_KIPINTCFG_BASE_INSERT;
