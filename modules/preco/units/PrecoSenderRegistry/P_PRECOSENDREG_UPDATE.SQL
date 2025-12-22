/* Исправление отправителя */
create or replace procedure P_PRECOSENDREG_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  nCOMPANY                  in number,       -- Организация
  sCODE                     in varchar2,     -- Код
  sNAME                     in varchar2,     -- Наименование
  nSYSTEM                   in number,       -- Система
  nIS_ACTIVE                in number        -- Активен
)
as
  nCRN                      PKG_STD.tREF;    -- Каталог
begin
  /* Считывание записи */
  P_PRECOSENDREG_EXISTS
  (
    nRN,
    nCOMPANY,
    nCRN
  );

  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,nCRN,null,null,'PrecoSenderRegistry','PRECOSENDREG_UPDATE','PRECOSENDREG',nRN );

  /* Базовое исправление */
  P_PRECOSENDREG_BASE_UPDATE
  (
    nRN,
    nCOMPANY,
    sCODE,
    sNAME,
    nSYSTEM,
    nIS_ACTIVE
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,nCRN,null,null,'PrecoSenderRegistry','PRECOSENDREG_UPDATE','PRECOSENDREG',nRN );
end;
/
show errors procedure P_PRECOSENDREG_UPDATE;
