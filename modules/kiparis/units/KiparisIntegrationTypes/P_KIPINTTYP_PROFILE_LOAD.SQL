/* Загрузка профиля */
create or replace procedure P_KIPINTTYP_PROFILE_LOAD
(
  nPROCESS                  in number        -- Идентификатор процесса
)
as
  xDOC                      PKG_XPATH.tDOCUMENT;
  xROOT                     PKG_XPATH.tNODE;
  xNODE                     PKG_XPATH.tNODE;
  xLIST                     PKG_XPATH.tNODES;

  bPROFILE                  blob;
  bEXISTS                   boolean := false;
  rKIPINTTYP                KIPINTTYP%rowtype;
  rKIPINTTYPFLD             KIPINTTYPFLD%rowtype;
begin
  /* цикл по файлам */
  for cPROFILE in
  (
    select DATA
      from FILE_BUFFER
     where IDENT = nPROCESS
  )
  loop
    bPROFILE := clob2blob(cPROFILE.DATA);

    xDOC := PKG_XPATH.PARSE_FROM_BLOB(bPROFILE);

    begin
      xROOT := PKG_XPATH.ROOT_NODE(xDOC);
      xNODE := PKG_XPATH.SINGLE_NODE(xROOT, 'kiparisprofile/system');

      /* Чтение атрибутов профиля */
      rKIPINTTYP.CODE := PKG_XPATH.ATTRIBUTE(xNODE, 'code');
      rKIPINTTYP.NAME := PKG_XPATH.ATTRIBUTE(xNODE, 'name');

      /* Поиск профиля */
      FIND_KIPINTTYP_CODE(1, PKG_XPATH.ATTRIBUTE(xNODE, 'code'), rKIPINTTYP.RN);
      if rKIPINTTYP.RN is not null then
        /* Обновление профиля */
        P_KIPINTTYP_BASE_UPDATE(rKIPINTTYP.RN, rKIPINTTYP.CODE, rKIPINTTYP.NAME);
      else
        /* Вставка профиля */
        P_KIPINTTYP_BASE_INSERT(rKIPINTTYP.CODE, rKIPINTTYP.NAME, rKIPINTTYP.RN);
      end if;

      xLIST := PKG_XPATH.LIST_NODES(xNODE, 'fields/field');
      for i in 1..PKG_XPATH.COUNT_NODES(xLIST) loop
        xNODE := PKG_XPATH.ITEM_NODE(xLIST, i);

        /* Чтение атрибутов параметра */
        rKIPINTTYPFLD.PRN := rKIPINTTYP.RN;
        rKIPINTTYPFLD.FLD_CODE := PKG_XPATH.ATTRIBUTE(xNODE, 'fld_code');
        rKIPINTTYPFLD.FLD_NAME := PKG_XPATH.ATTRIBUTE(xNODE, 'fld_name');
        rKIPINTTYPFLD.ENTRY_TYPE := to_number(PKG_XPATH.ATTRIBUTE(xNODE, 'entry_type'));
        rKIPINTTYPFLD.DATA_TYPE := to_number(PKG_XPATH.ATTRIBUTE(xNODE, 'data_type'));
        rKIPINTTYPFLD.STPOLICY := to_number(PKG_XPATH.ATTRIBUTE(xNODE, 'stpolicy'));
        rKIPINTTYPFLD.BUNDLE := PKG_XPATH.ATTRIBUTE(xNODE, 'bundle');
    
        /* Поиск параметра */
        FIND_KIPINTTYPFLD_CODE(1, rKIPINTTYPFLD.FLD_CODE, rKIPINTTYPFLD.RN);
        if rKIPINTTYPFLD.RN is not null then
          /* Обновление параметра */
          P_KIPINTTYPFLD_BASE_UPDATE(rKIPINTTYPFLD.RN, rKIPINTTYPFLD.FLD_CODE, rKIPINTTYPFLD.FLD_NAME,
                                     rKIPINTTYPFLD.ENTRY_TYPE, rKIPINTTYPFLD.DATA_TYPE, rKIPINTTYPFLD.STPOLICY, rKIPINTTYPFLD.BUNDLE);
        else
          /* Вставка параметра */
          P_KIPINTTYPFLD_BASE_INSERT(rKIPINTTYPFLD.PRN, rKIPINTTYPFLD.FLD_CODE, rKIPINTTYPFLD.FLD_NAME,
                                     rKIPINTTYPFLD.ENTRY_TYPE, rKIPINTTYPFLD.DATA_TYPE, rKIPINTTYPFLD.STPOLICY, rKIPINTTYPFLD.BUNDLE, rKIPINTTYPFLD.RN);
        end if;
      end loop;

      PKG_XPATH.FREE(xDOC);
      dbms_lob.freetemporary(bPROFILE);
    exception
      when OTHERS then
        PKG_XPATH.FREE(xDOC);
        dbms_lob.freetemporary(bPROFILE);
    end;

    bEXISTS := true;
  end loop;

  if not bEXISTS then
    P_EXCEPTION(0, 'Профили для загрузки не найдены.');
  end if;
end;
/
show errors procedure P_KIPINTTYP_PROFILE_LOAD;
