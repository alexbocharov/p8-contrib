/* Исправление значения параметра настройки интеграции */
create or replace procedure P_KIPINTCFGVAL_UPDATE
(
  nRN                       in number,       -- Регистрационный номер
  sVAL_STR                  in varchar2,     -- Значение: строка
  nVAL_NUM                  in number,       -- Значение: число
  dVAL_DATE                 in date,         -- Значение: дата
  nVAL_BOOL                 in number        -- Значение: да/нет
)
as
  rVAL                      KIPINTCFGVAL%rowtype;
  rFLD                      KIPINTTYPFLD%rowtype;
  
  sFINAL_STR                varchar2(4000);
  nFINAL_NUM                number(17,5);
  dFINAL_DATE               date;
begin
  /* Считываем контекст записи и метаданные поля */
  select V.*, F.*
    into rVAL.RN, rVAL.COMPANY, rVAL.PRN, rVAL.CRN, rVAL.JUR_PERS, rVAL.KIPINTTYPFLD, 
         rVAL.VAL_STR, rVAL.VAL_NUM, rVAL.VAL_DATE, rVAL.VAL_REF,
         rFLD.RN, rFLD.PRN, rFLD.FLD_CODE, rFLD.FLD_NAME, rFLD.SORT_ORDER, rFLD.ENTRY_TYPE, 
         rFLD.DATA_TYPE, rFLD.STPOLICY, rFLD.BUNDLE
    from KIPINTCFGVAL V
    join KIPINTTYPFLD F on V.KIPINTTYPFLD = F.RN
   where V.RN = nRN;

  /* Проверка: если параметр уже в Vault, прямое редактирование запрещено */
  if rVAL.VAL_REF is not null then
     P_EXCEPTION(0, 'Параметр находится в защищенном хранилище. Редактирование запрещено.');
  end if;

  /* Фиксация начала действия */
  PKG_ENV.PROLOGUE(rVAL.COMPANY, null, rVAL.CRN, rVAL.JUR_PERS, null, 'KiparisIntegrationConfigsVals', 'KIPINTCFGVAL_UPDATE', 'KIPINTCFGVAL', nRN);

  /* Распределение данных по физическим колонкам */
  
  -- Случай А: Чекбокс (ENTRY_TYPE = 2) -> пишем в VAL_NUM
  if rFLD.ENTRY_TYPE = 2 then
     nFINAL_NUM := nVAL_BOOL;
     
  -- Случай Б: Секретный ввод (ENTRY_TYPE = 1) -> шифруем и пишем в VAL_STR
  elsif rFLD.ENTRY_TYPE = 1 then
     -- Используем KIP_SENTRY.GUARD для AES-256 шифрования
     -- Результат GUARD (RAW) приводим к VARCHAR2 для хранения в VAL_STR (HEX/Base64)
     sFINAL_STR := rawtohex(KIP_SENTRY.GUARD(nRN, sVAL_STR));
     
  -- Случай В: Обычные данные на основе DATA_TYPE
  else
     case rFLD.DATA_TYPE
       when 1 then nFINAL_NUM  := nVAL_NUM;  -- Число
       when 2 then dFINAL_DATE := dVAL_DATE; -- Дата
       else        sFINAL_STR  := sVAL_STR;  -- Обычная строка
     end case;
  end if;

  /* Базовое обновление в таблице */
  update KIPINTCFGVAL
     set VAL_STR  = sFINAL_STR,
         VAL_NUM  = nFINAL_NUM,
         VAL_DATE = dFINAL_DATE
   where RN = nRN;

  /* Фиксация окончания действия */
  PKG_ENV.EPILOGUE(rVAL.COMPANY, null, rVAL.CRN, rVAL.JUR_PERS, null, 'KiparisIntegrationConfigsVals', 'KIPINTCFGVAL_UPDATE', 'KIPINTCFGVAL', nRN);
  
exception
  when OTHERS then
     P_EXCEPTION(0, 'Ошибка при сохранении параметра: ' || SQLERRM);
end;
/
show errors procedure P_KIPINTCFGVAL_UPDATE;
