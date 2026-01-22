create or replace package PKG_PRECO_EXCHANGE
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

  procedure GET_RECORD_BY_RN
  (
    nRN                     in     number,        -- Регистрационный номер
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с записью
  );

  procedure GET_PENDING_FOR_QUEUE
  (
    nLIMIT                  in     number,        -- Лимит записей
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с регистрационными номерами
  );

  procedure GET_PENDING_FOR_STATUS_CHK
  (
    nLIMIT                  in     number,        -- Лимит записей
    pCURSOR                 out    SYS_REFCURSOR  -- Курсор с идентификаторами сообщений
  );

  procedure SET_STATUS
  (
    nRN                     in number,       -- Регистрационный номер
    sSTATUS                 in varchar2,     -- Статус
    sERR_CODE               in varchar2,     -- Код ошибки
    sERR_TEXT               in varchar2      -- Текст ошибки
  );

end PKG_PRECO_EXCHANGE;
/
show errors package PKG_PRECO_EXCHANGE;