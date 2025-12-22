/* Добавление/размножение отправителя */
create or replace procedure P_PRECOSENDREG_INSERT
(
  nCOMPANY                  in number,       -- Организация
  nCRN                      in number,       -- Каталог
  sCODE                     in varchar2,     -- Код
  sNAME                     in varchar2,     -- Наименование
  nSYSTEM                   in number,       -- Система
  nIS_ACTIVE                in number,       -- Активен
  nRN                       out number       -- Регистрационный номер
)
as
begin
  /* фиксация начала выполнения действия */
  PKG_ENV.PROLOGUE( nCOMPANY,null,nCRN,null,null,'PrecoSenderRegistry','PRECOSENDREG_INSERT','PRECOSENDREG' );

  /* Базовое добавление */
  P_PRECOSENDREG_BASE_INSERT
  (
    nCOMPANY,
    nCRN,
    sCODE,
    sNAME,
    nSYSTEM,
    nIS_ACTIVE,
    nRN
  );

  /* фиксация окончания выполнения действия */
  PKG_ENV.EPILOGUE( nCOMPANY,null,nCRN,null,null,'PrecoSenderRegistry','PRECOSENDREG_INSERT','PRECOSENDREG',nRN );
end;
/
show errors procedure P_PRECOSENDREG_INSERT;
