/* Отправить в "ПРЕКО. Платформа сбора первичной отчётности. Журнал исходящего обмена отчётностью" */
create or replace procedure FIND_CLOB_INFO
(
  cCLOB                     in clob,         -- CLOB для поиска
  sSTART                    in varchar2,     -- Начало поиска
  sEND                      in varchar2,     -- Конец поиска
  sSEARCH                   out varchar2     -- Найденная строка
)
as
  nPOS_START                PKG_STD.tNUMBER;
  nPOS_END                  PKG_STD.tNUMBER;
begin
  sSEARCH := null;

  nPOS_START := instr(cCLOB, sSTART);
  if nPOS_START > 0 then
    nPOS_END := instr(cCLOB, sEND, nPOS_START + length(sSTART));
    if nPOS_END > nPOS_START then
      sSEARCH := substr(cCLOB, nPOS_START + length(sSTART), nPOS_END - (nPOS_START + length(sSTART)));
    end if;
  end if;
end;
/
show errors procedure FIND_CLOB_INFO;
