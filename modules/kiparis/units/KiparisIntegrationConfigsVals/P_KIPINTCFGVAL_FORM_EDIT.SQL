/* Клиентская процедура для формы редактирования раздела "Кипарис. Настройки интеграций (Параметры)" */  
create or replace procedure P_KIPINTCFGVAL_FORM_EDIT
(
  nRN                       in number,       -- Регистрационный номер
  nINIT_EDIT                in out number,   -- Вызов (0 - инициализация, 1 - изменение полей)
  nPARAM1_PWD_CODE          in out number,   -- Код маски для пароля (если применимо)
  sPARAM1_VAL               in out varchar2, -- Значение параметра (строка) 
  nPARAM2_VAL               in out number,   -- Значение параметра (число)
  dPARAM3_VAL               in out date,     -- Значение параметра (дата)
  nPARAM4_VAL               in out number,   -- Значение параметра (да/нет)
  nGRP1_VS                  out number,      -- Группа 1. Значение строка (видимость)
  nGRP2_VS                  out number,      -- Группа 2. Значение число (видимость)
  nGRP3_VS                  out number,      -- Группа 3. Значение дата (видимость)
  nGRP4_VS                  out number,      -- Группа 4. Значение да/нет (видимость)
  sGRP1_NAME                out varchar2,    -- Группа 1. Название
  sGRP2_NAME                out varchar2,    -- Группа 2. Название
  sGRP3_NAME                out varchar2,    -- Группа 3. Название
  sGRP4_NAME                out varchar2,    -- Группа 4. Название
  sPARAM1_HINT              out varchar2,    -- Подсказка для параметра 1
  sPARAM2_HINT              out varchar2,    -- Подсказка для параметра 2
  sPARAM3_HINT              out varchar2,    -- Подсказка для параметра 3
  sPARAM4_HINT              out varchar2     -- Подсказка для параметра 4
)
as
  rVAL                      KIPINTCFGVAL%rowtype;
  rFLD                      KIPINTTYPFLD%rowtype;
begin
  /* Инициализация флага вызова */
  nINIT_EDIT := nvl(nINIT_EDIT, 0);

  /* Читаем значение и его описание */
  select V.*, F.*
    into rVAL.RN, rVAL.COMPANY, rVAL.PRN, rVAL.CRN, rVAL.JUR_PERS, rVAL.KIPINTTYPFLD, 
         rVAL.VAL_STR, rVAL.VAL_NUM, rVAL.VAL_DATE, rVAL.VAL_REF,
         rFLD.RN, rFLD.PRN, rFLD.FLD_CODE, rFLD.FLD_NAME, rFLD.ENTRY_TYPE, 
         rFLD.DATA_TYPE, rFLD.STPOLICY, rFLD.BUNDLE
    from KIPINTCFGVAL V
          join KIPINTTYPFLD F on V.KIPINTTYPFLD = F.RN
   where V.RN = nRN;

  /* Скрываем все группы по умолчанию */
  nGRP1_VS := 0;
  nGRP2_VS := 0;
  nGRP3_VS := 0;
  nGRP4_VS := 0;

  /* Устанавливаем заголовки и подсказки */
  sGRP1_NAME := rFLD.FLD_NAME;
  sGRP2_NAME := rFLD.FLD_NAME;
  sGRP3_NAME := rFLD.FLD_NAME;
  sGRP4_NAME := rFLD.FLD_NAME;
  sPARAM1_HINT := rFLD.FLD_NAME;
  sPARAM2_HINT := rFLD.FLD_NAME;
  sPARAM3_HINT := rFLD.FLD_NAME;
  sPARAM4_HINT := rFLD.FLD_NAME;

  /* --- ПЕРВИЧНОЕ ЗАПОЛНЕНИЕ ЗНАЧЕНИЙ (только при открытии формы) --- */
  if nINIT_EDIT = 0 then
    -- Строка (очищаем, если это секрет или бандл, иначе заполняем)
    if (rFLD.ENTRY_TYPE in (1, 3)) or (rVAL.VAL_REF is not null) then
        sPARAM1_VAL := ''; 
    else
        sPARAM1_VAL := rVAL.VAL_STR;
    end if;

    -- Число и Чекбокс (оба берут данные из VAL_NUM)
    nPARAM2_VAL := rVAL.VAL_NUM;
    nPARAM4_VAL := nvl(rVAL.VAL_NUM, 0); -- Для чекбокса важно 0 или 1

    -- Дата
    dPARAM3_VAL := rVAL.VAL_DATE;
  end if;

  /* --- ЛОГИКА ОТОБРАЖЕНИЯ --- */
  
  -- Сценарий 1: Чекбокс (ENTRY_TYPE = 2)
  if rFLD.ENTRY_TYPE = 2 then
    nGRP4_VS := 1; 

  -- Сценарий 2: Контейнер Bundle (ENTRY_TYPE = 3)
  elsif rFLD.ENTRY_TYPE = 3 then
    nGRP1_VS := 1; 
    nPARAM1_PWD_CODE := 42;
    sPARAM1_HINT := 'Групповой контейнер секретов. Редактирование запрещено.';

  -- Сценарий 3: Распределение по физическому типу DATA_TYPE
  else
    case rFLD.DATA_TYPE
      when 1 then nGRP2_VS := 1; -- Число
      when 2 then nGRP3_VS := 1; -- Дата
      else
        nGRP1_VS := 1; -- Строка
        if rFLD.ENTRY_TYPE = 1 then
          nPARAM1_PWD_CODE := 42;
          sPARAM1_HINT := rFLD.FLD_NAME || ' (Зашифровано). Введите новое значение для смены.';
        end if;
    end case;
  end if;

  /* Защита Vault */
  if rVAL.VAL_REF is not null then
    nGRP1_VS := 1;
    nGRP2_VS := 0;
    nGRP3_VS := 0;
    nGRP4_VS := 0;
    nPARAM1_PWD_CODE := 42;
    sPARAM1_HINT := 'Засекречено в Vault. Для смены выполните процедуру сброса.';
  end if;

  /* Фиксируем инициализацию */
  nINIT_EDIT := 1;

exception
  when NO_DATA_FOUND then 
    null;
  when OTHERS then 
    P_EXCEPTION(0, 'Ошибка настройки формы: ' || SQLERRM);
end;
/
show errors procedure P_KIPINTCFGVAL_FORM_EDIT;