/* Базовое изменение статуса журнала */
create or replace procedure P_PRECOINEXJR_BSET_STATUS
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sSTATUS                   in varchar2,     -- Статус
  dUPDATED                  in date          -- Дата модификации
)
as
begin
  /* изменение статуса в таблице */
  update PRECOINEXJR
     set STATUS = sSTATUS,
         UPDATED = dUPDATED
   where RN = nRN
     and COMPANY = nCOMPANY;

  if (SQL%NOTFOUND) then
    PKG_MSG.RECORD_NOT_FOUND( nRN,'PrecoInputExchangeJournal' );
  end if;
end;
/
show errors procedure P_PRECOINEXJR_BSET_STATUS;