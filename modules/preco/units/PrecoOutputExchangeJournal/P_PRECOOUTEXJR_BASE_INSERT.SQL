/* Базовое добавление */
create or replace procedure P_PRECOOUTEXJR_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  nJUR_PERS                 in number,       -- Ссылка на юридическое лицо
  sREPORT_CODE              in varchar2,     -- Код отчета (Форма)
  dREPORT_DATE              in date,         -- Дата отчета
  sREPORT_NAME              in varchar2,     -- Наименование отчета
  sID                       in varchar2,     -- Идентификатор экземпляра отчёта
  sSENDER_CODE              in varchar2,     -- Код системы-отправителя
  bCONTENT                  in blob,         -- Содержимое
  sSTATUS                   in varchar2,     -- Статус
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into PRECOOUTEXJR
  (
    RN,
    COMPANY,
    CRN,
    JUR_PERS,
    REPORT_CODE,
    REPORT_DATE,
    REPORT_NAME,
    ID,
    SENDER_CODE,
    CONTENT,
    STATUS
  )
  values
  (
    nRN,
    nCOMPANY,
    nCRN,
    nJUR_PERS,
    sREPORT_CODE,
    dREPORT_DATE,
    sREPORT_NAME,
    sID,
    sSENDER_CODE,
    bCONTENT,
    sSTATUS
  );
end;
/
show errors procedure P_PRECOOUTEXJR_BASE_INSERT;
