/* Базовое добавление */
create or replace procedure P_PRECOOUTEXJR_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  nJUR_PERS                 in number,       -- Ссылка на юридическое лицо
  sREPORT_CODE              in varchar2,     -- Код отчета (Форма)
  dREPORT_DATE              in date,         -- Дата отчета
  sREPORT_NAME              in varchar2,     -- Наименование отчета
  sMSG_ID                   in varchar2,     -- Идентификатор сообщения
  sSENDER_CODE              in varchar2,     -- Код системы-отправителя
  sSTATUS                   in varchar2,     -- Статус
  dCREATED                  in date,         -- Дата создания
  dUPDATED                  in date,         -- Дата модификации
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
    MSG_ID,
    SENDER_CODE,
    STATUS,
    CREATED,
    UPDATED
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
    sMSG_ID,
    sSENDER_CODE,
    sSTATUS,
    dCREATED,
    dUPDATED
  );
end;
/
show errors procedure P_PRECOOUTEXJR_BASE_INSERT;
