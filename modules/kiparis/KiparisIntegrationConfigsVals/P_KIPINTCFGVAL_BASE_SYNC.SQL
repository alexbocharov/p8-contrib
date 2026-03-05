/* Синхронизация состава параметров настройки по метаданным  */
create or replace procedure P_KIPINTCFGVAL_BASE_SYNC
(
  nCOMPANY                  in number,       -- Организация
  nKIPINTCFG                in number,       -- Ссылка на настройку интеграции
  nKIPINTTYP                in number        -- Ссылка на вид интеграций КИПАРИС
)
as
  nTMP_RN                   PKG_STD.tREF;    -- Временный регистрационный номер
begin
  /* Проходим по всем полям метаданных для данного вида системы */
  for cFLD in
  (
    select RN 
      from KIPINTTYPFLD 
     where PRN = nKIPINTTYP
       and ENTRY_TYPE != 3 -- Исключаем контейнеры (Bundle), они создаются при упаковке
       -- Исключаем уже существующие записи
       and not exists (select 1 from KIPINTCFGVAL where PRN = nKIPINTCFG)
  )
  loop
    /* Генерируем базовую запись для каждого поля */
    P_KIPINTCFGVAL_BASE_INSERT
    (
      nCOMPANY,
      nKIPINTCFG,
      cFLD.RN,
      nTMP_RN
    );
  end loop;
end;
/
show errors procedure P_KIPINTCFGVAL_BASE_SYNC;
