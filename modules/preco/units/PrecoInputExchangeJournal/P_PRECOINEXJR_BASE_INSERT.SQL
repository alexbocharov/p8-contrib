/* Базовое добавление */
create or replace procedure P_PRECOINEXJR_BASE_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  nAGENT                    in number,       -- Ссылка на контрагента
  sREPORT_CODE              in varchar2,     -- Код отчета (Форма)
  dREPORT_DATE              in date,         -- Дата отчета
  sID                       in varchar2,     -- Идентификатор экземпляра отчёта
  nPRECOSENDREG             in number,       -- Ссылка на реестр отправителей
  sSTATUS                   in varchar2,     -- Статус
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* генерация регистрационного номера */
  nRN := gen_id;

  /* добавление записи в таблицу */
  insert into PRECOINEXJR
  (
    RN,
    COMPANY,
    CRN,
    AGENT,
    REPORT_CODE,
    REPORT_DATE,
    ID,
    PRECOSENDREG,
    STATUS
  )
  values
  (
    nRN,
    nCOMPANY,
    nCRN,
    nAGENT,
    sREPORT_CODE,
    dREPORT_DATE,
    sID,
    nPRECOSENDREG,
    sSTATUS
  );
end;
/
show errors procedure P_PRECOINEXJR_BASE_INSERT;
