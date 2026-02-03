create or replace package PKG_PRECOOUTEXJR_EXCHANGE
as
  sSTATUS_NEW               constant PKG_STD.tSTRING := 'NEW';                -- Новая
  sSTATUS_QUEUED            constant PKG_STD.tSTRING := 'QUEUED';             -- В очереди на отправку
  sSTATUS_SENDING           constant PKG_STD.tSTRING := 'SENDING';            -- Отправляется
  sSTATUS_SENT              constant PKG_STD.tSTRING := 'SENT';               -- Отправлена
  sSTATUS_PROCESSING_QUEUE  constant PKG_STD.tSTRING := 'PROCESSING_QUEUED';  -- В очереди на обработку
  sSTATUS_PROCESSING        constant PKG_STD.tSTRING := 'PROCESSING';         -- Обрабатывается
  sSTATUS_PROCESSED         constant PKG_STD.tSTRING := 'PROCESSED';          -- Обработана
  sSTATUS_ERROR             constant PKG_STD.tSTRING := 'ERROR';              -- Ошибка
  sSTATUS_UPDATED           constant PKG_STD.tSTRING := 'UPDATED';            -- Обновлена

  procedure GET_BATCH_FOR_SENDING
  (
    nBATCH_SIZE             in number,            -- Размер пакета
    pCURSOR                 out sys_refcursor     -- Курсор с метаданными передаваемых отчётов
  );

  procedure GET_CONTENT_BY_ID
  (
    sID                     in varchar2,          -- Идентификатор экземпляра отчета
    pCLOB                   out clob              -- CLOB с содержимым отчёта
  );

  procedure GET_RECORD_BY_ID
  (
    sID                     in varchar2,          -- Идентификатор экземпляра отчета
    pCURSOR                 out sys_refcursor     -- Курсор с записью
  );

  procedure GET_PENDING_FOR_QUEUE
  (
    nLIMIT                  in number,            -- Лимит записей
    pCURSOR                 out sys_refcursor     -- Курсор с регистрационными номерами
  );

  procedure GET_PENDING_FOR_STATUS_CHK
  (
    nLIMIT                  in number,            -- Лимит записей
    pCURSOR                 out sys_refcursor     -- Курсор с идентификаторами сообщений
  );

  procedure SET_STATUS
  (
    sID                     in varchar2,          -- Идентификатор экземпляра отчета
    sSTATUS                 in varchar2,          -- Статус
    sERR_CODE               in varchar2,          -- Код ошибки
    sERR_TEXT               in varchar2           -- Текст ошибки
  );

end PKG_PRECOOUTEXJR_EXCHANGE;
/
show errors package PKG_PRECOOUTEXJR_EXCHANGE;