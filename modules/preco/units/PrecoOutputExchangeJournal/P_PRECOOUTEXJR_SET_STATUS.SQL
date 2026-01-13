/* Изменение статуса журнала и истории */
create or replace procedure P_PRECOOUTEXJR_SET_STATUS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sSTATUS                   in varchar2,     -- Статус
  sERR_CODE                 in varchar2,     -- Код ошибки
  sERR_TEXT                 in varchar2      -- Текст ошибки
)
as
begin
  /* изменение статуса */
  P_PRECOOUTEXJR_SET_STATUS_EX( nRN,nCOMPANY,sSTATUS,sERR_CODE,sERR_TEXT,sysdate );
end;
/
show errors procedure P_PRECOOUTEXJR_SET_STATUS;