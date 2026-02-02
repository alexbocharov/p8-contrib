/* Функция поиска подстроки в CLOB */
create or replace function GET_CLOB_EXTRACT_BETWEEN
(
  nFLAG_SMART               in number,       -- признак генерации исключения (0 - да, 1 - нет)
  cCLOB                     in clob,         -- CLOB для поиска
  sSTART                    in varchar2,     -- Начало поиска
  sEND                      in varchar2      -- Конец поиска
) return varchar2
as
  nPOS_START                PKG_STD.tNUMBER;
  nPOS_END                  PKG_STD.tNUMBER;
  sSEARCH                   PKG_STD.tSTRING;
begin
  sSEARCH := null;

  nPOS_START := instr(cCLOB, sSTART);
  if (nPOS_START = 0) then
    P_EXCEPTION( nFLAG_SMART, 'Начальный токен "%s" не найден в CLOB.',sSTART );
  end if;

  nPOS_END := instr(cCLOB, sEND, nPOS_START + length(sSTART));
  if (nPOS_END = 0 or nPOS_END <= nPOS_START) then
    P_EXCEPTION( nFLAG_SMART, 'Конечный токен "%s" не найден в CLOB.',sEND );
  end if;

  sSEARCH := substr(cCLOB, nPOS_START + length(sSTART), nPOS_END - (nPOS_START + length(sSTART)));

  sSEARCH := regexp_replace(sSEARCH, '[[:cntrl:]]', '');

  return sSEARCH;
end;
/
show errors function GET_CLOB_EXTRACT_BETWEEN;