/* Базовое исправление */
create or replace procedure P_PRECOOUTEXJR_BASE_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  nJUR_PERS                 in number,       -- Ссылка на юридическое лицо
  sREPORT_CODE              in varchar2,     -- Код отчета (Форма)
  dREPORT_DATE              in date,         -- Дата отчета
  sREPORT_NAME              in varchar2,     -- Наименование отчета
  sMSG_ID                   in varchar2,     -- Идентификатор сообщения
  sSENDER_CODE              in varchar2,     -- Код системы-отправителя
  sSTATUS                   in varchar2,     -- Статус
  dCREATED                  in date,         -- Дата создания
  dUPDATED                  in date          -- Дата модификации
)
as
begin
  /* исправление записи в таблице */
  update PRECOOUTEXJR
     set JUR_PERS = nJUR_PERS,
         REPORT_CODE = sREPORT_CODE,
         REPORT_DATE = dREPORT_DATE,
         REPORT_NAME = sREPORT_NAME,
         MSG_ID = sMSG_ID,
         SENDER_CODE = sSENDER_CODE,
         STATUS = sSTATUS,
         CREATED = dCREATED,
         UPDATED = dUPDATED
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoOutputExchangeJournal' );
  end if;
end;
/
show errors procedure P_PRECOOUTEXJR_BASE_UPDATE;
