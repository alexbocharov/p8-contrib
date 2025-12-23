/* Клиентская процедура для формы редактирования раздела "ПРЕКО. Платформа сбора первичной отчётности. Сопоставление каталогов загрузки и контрагентов" */  
create or replace procedure P_PRECODIRCTRMAP_FORM_EDIT
(
  nCOMPANY                  in number,       -- Организация
  sAGNABBR                  in varchar2,     -- Мнемокод контрагента
  sAGNNAME                  in out varchar2, -- Наименование контрагента
  sAGNIDNUMB                in out varchar2, -- ИНН контрагента
  sREASON_CODE              in out varchar2, -- КПП контрагента
  sBLREPCRN_NAME            in out varchar2  -- Каталог загрузки
)
as
  nVERSION                  PKG_STD.tREF;    -- Версия
begin
  /* определение версии */
  FIND_VERSION_BY_COMPANY( nCOMPANY,'AGNLIST',nVERSION );

  begin
    select AG.AGNNAME,
           AG.AGNIDNUMB,
           AG.REASON_CODE
      into sAGNNAME,
           sAGNIDNUMB,
           sREASON_CODE
      from AGNLIST AG
     where AG.AGNABBR = sAGNABBR
       and AG.VERSION = nVERSION;
  exception
    when NO_DATA_FOUND then
      sAGNNAME     := null;
      sAGNIDNUMB   := null;
      sREASON_CODE := null;
  end;
end;
/
show errors procedure P_PRECODIRCTRMAP_FORM_EDIT;