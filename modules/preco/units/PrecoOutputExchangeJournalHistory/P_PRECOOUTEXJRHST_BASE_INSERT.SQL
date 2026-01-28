/* Базовое добавление */
create or replace procedure P_PRECOOUTEXJRHST_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nPRN                      in number,       -- Родитель
  nNUMB                     in number,       -- Порядковый номер
  sID                       in varchar2,     -- Идентификатор экземпляра отчёта
  sAUTHID                   in varchar2,     -- Пользователь
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2,     -- Текст ошибки
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into PRECOOUTEXJRHST
  (
    RN,
    PRN,
    NUMB,
    ID,
    AUTHID,
    STATUS,
    ERR_CODE,
    ERR_TEXT
  )
  values
  (
    nRN,
    nPRN,
    nNUMB,
    sID,
    sAUTHID,
    sSTATUS,
    sERR_CODE,
    sERR_TEXT
  );
end;
/
show errors procedure P_PRECOOUTEXJRHST_BASE_INSERT;
