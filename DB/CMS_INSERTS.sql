delete from cms_operation_users;
delete from cms_screen_elements;
delete from cms_operation_screens;
delete from cms_operations;
delete from cms_users;
/
begin
  insert into CMS_USERS(id, password, description, check_pass, can_modify) values('admin', '21232f297a57a5a743894a0e4a801fc3', 'ADMIN', 'YES', 'YES');
  -- operacja
  insert into CMS_OPERATIONS(ID, SEQ, ORDINAL, NAME, STATE_ID, DESCRIPTION, VERSION)
  values('UPSERT_OP', OP_SEQ.nextval, -1, '[UPSERT_OPERATIONS]', 'ACTIVE', 'Tworzenie modyfikacja zadań', '<1.0.0>');
  ------------------------------------------------------------------------------
  ---------------------------------CHOICE_OP------------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 10, 'UPSERT_OP', '[CHOICE_OP]', 'ACTIVE', 'YES', 'YES', 'NO', 'Wybór operacji');
  -- {CHOICE_LABEL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'CHOICE_LABEL10', OPSCR_SEQ.currval, 'LABEL', '{CHOICE_LABEL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_SCR]', 'Lista Operacji:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_OP}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'CHOICE_OP', OPSCR_SEQ.currval, 'TABELA', '{CHOICE_OP}', '', '',
  '',
  'select id id_g, description "Operacja" from cms_operations where id not in(''UPSERT_OP'', ''UPSERT_USER'') and state_id = ''ACTIVE''',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_SCR]', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_BUTTON10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'CHOICE_OPBTN10', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_OPBTN10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[NEW_OP]', 'Twórz nową operacje', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  ----------------------------------NEW_OP--------------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 20, 'UPSERT_OP', '[NEW_OP]', 'ACTIVE', 'YES', 'YES', 'NO', 'Tworzenie operacji');
  -- {NEWOP_LABEL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'NEWOP_LABEL10', OPSCR_SEQ.currval, 'LABEL', '{NEWOP_LABEL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Podaj nazwę operacji', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWOP_NAME}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'NEWOP_NAME', OPSCR_SEQ.currval, 'TEXT', '{NEWOP_NAME}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWOP_BUTTON10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'NEWOP_BUTTON10', OPSCR_SEQ.currval, 'BUTTON', '{NEWOP_BUTTON10}', '', '',
  'case 
     when exists(select 1 
                   from cms_operations 
                  where description = {NEWOP_NAME}) 
     then ''Istnieje już operacja o podanej nazwie'' 
     else null 
   end',
  'declare 
     cursor c_ordinal is 
            select nvl(max(greatest(ordinal, 0)), 0) + 1 
              from cms_operations; 
     z_i number;
   begin 
     open c_ordinal;
     fetch c_ordinal into z_i;
     close c_ordinal;
     --
     insert into cms_operations(id, seq, ordinal, name, description)
     values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, z_i, ''[OP_''||z_i||'']'',{NEWOP_NAME});
     --
     {PHP_RETURN} := OPSCR_SEQ.currval;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[NEW_SCR]', 'Dalej', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWOP_BUTTON20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'NEWOP_BUTTON20', OPSCR_SEQ.currval, 'BUTTON', '{NEWOP_BUTTON20}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_OP]', 'Wróć', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  --
  ------------------------------------------------------------------------------
  ---------------------------------NEW_SCR--------------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 30, 'UPSERT_OP', '[NEW_SCR]', 'ACTIVE', 'YES', 'YES', 'NO', 'Tworzenie ekranu');
  -- {NEWSCR_SCRIPT}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'NEWSCR_SCRIPT', OPSCR_SEQ.currval, 'SCRIPT', '{NEWSCR_SCRIPT}', '', '',
  '',
  'begin 
     {CHOICE_OP} := nvl({PHP_RETURN}, {CHOICE_OP});
     {CHOICE_SCR} := null;
     {PHP_RETURN} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWSCR_LABEL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'NEWSCR_LABEL10', OPSCR_SEQ.currval, 'LABEL', '{NEWSCR_LABEL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Podaj nazwę ekranu:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWSCR_NAME}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'NEWSCR_NAME', OPSCR_SEQ.currval, 'TEXT', '{NEWSCR_NAME}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWSCR_BUTTON10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 5, 'NEWSCR_BUTTON10', OPSCR_SEQ.currval, 'BUTTON', '{NEWSCR_BUTTON10}', '', '',
  'case 
     when exists(select 1 
                   from cms_operation_screens scr
                  where name = {NEWSCR_NAME}
                    and op_id = {CHOICE_OP}) 
     then ''Istnieje już ekran o podanej nazwie'' 
     else null 
   end',
  'declare 
     cursor c_ordinal is 
            select nvl(max(greatest(ordinal, 0)), 0) + 1 
              from cms_operations; 
     z_i number;
   begin 
     open c_ordinal;
     fetch c_ordinal into z_i;
     close c_ordinal;
     --
     insert into cms_operation_screens(id, seq, name, op_id, description)
     values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, {NEWSCR_NAME}, {CHOICE_OP}, replace(replace({NEWSCR_NAME}, '']'', ''''), ''['', ''''));
     --
     {PHP_RETURN} := OPSCR_SEQ.currval;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[NEW_ELEM]', 'Dalej', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  ---------------------------------NEW_ELEM-------------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 40, 'UPSERT_OP', '[NEW_ELEM]', 'ACTIVE', 'YES', 'YES', 'NO', 'Tworzenie elementu');
  -- {NEWELEM_SCRIPT}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'NEWELEM_SCRIPT', OPSCR_SEQ.currval, 'SCRIPT', '{NEWELEM_SCRIPT}', '', '',
  '',
  'begin 
     {CHOICE_SCR} := nvl({PHP_RETURN}, {CHOICE_SCR});
     {CHOICE_ELEM} := null;
     {PHP_RETURN} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_LABEL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'NEWELEM_LABEL10', OPSCR_SEQ.currval, 'LABEL', '{NEWELEM_LABEL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Nazwa elementu:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_NAME}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB,
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'NEWELEM_NAME', OPSCR_SEQ.currval, 'TEXT', '{NEWELEM_NAME}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  '''Każdy element musi wyglądać w następny sposób {NAZWA_ZMIENNEJ}, ponieważ każdy element może być zmienną''');
  -- {NEWELEM_LABEL20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 5, 'NEWELEM_LABEL20', OPSCR_SEQ.currval, 'LABEL', '{NEWELEM_LABEL20}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Pozycja elementu:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_ORDINAL}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 6, 'NEWELEM_ORDINAL', OPSCR_SEQ.currval, 'NUMBER', '{NEWELEM_ORDINAL}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_LABEL30}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 7, 'NEWELEM_LABEL30', OPSCR_SEQ.currval, 'LABEL', '{NEWELEM_LABEL30}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Typ elmentu:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_TYPE}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 8, 'NEWELEM_TYPE', OPSCR_SEQ.currval, 'LIST', '{NEWELEM_TYPE}', '', '',
  '',
  'select ''TEXT'' id, ''Pole teksowe'' opis from dual
    union
   select ''BUTTON'' id, ''Przycisk'' opis from dual
    union
   select ''INFO'' id, ''Tabela info'' opis from dual
    union
   select ''JS'' id, ''JavaScript'' opis from dual
    union
   select ''LABEL'' id, ''Etykieta'' opis from dual
    union
   select ''LIST'' id, ''Lista'' opis from dual
    union
   select ''NUMBER'' id, ''Pole numeryczne'' opis from dual
    union
   select ''SCRIPT'' id, ''Skrypt'' opis from dual
    union
   select ''TABELA_CHECKBOX''  id, ''Tabela z checboxami'' opis from dual
    union
   select ''TABELA'' id, ''Tabela radio'' opis from dual
    union
   select ''TEXTAREA'' id, ''Obszar tekstowy'' opis from dual
    union
   select ''VAL'' id, ''Zmienna'' opis from dual',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_BUTTON10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 9, 'NEWELEM_BUTTON10', OPSCR_SEQ.currval, 'BUTTON', '{NEWELEM_BUTTON10}', '', '',
  'case 
     when exists(select 1 
                   from cms_screen_elements elem, 
                        cms_operation_screens scr,
                        cms_operations op
                  where elem.name = {NEWELEM_NAME}
                    and elem.opscr_id = scr.id
                    and scr.op_id = op.id
                    and op.id = {CHOICE_OP})
     then ''Podana nazwa elementu już istnieje''
     when {NEWELEM_TYPE} is null
     then ''Typ elementu jest wymagany''
     when {NEWELEM_NAME} is null
     then ''Nazwa elementu jest wymagany''
     when instr({NEWELEM_NAME}, ''{'') <= 0 or instr({NEWELEM_NAME}, ''}'') <= 0
     then ''Nazwa elementu musi się zaczynać od { i kończyć }''
     else null
   end',
  'begin
     --
     insert into cms_screen_elements(id, seq, ordinal, opscr_id, type, name, description)
     values(screlem_seq.nextval, screlem_seq.currval, {NEWELEM_ORDINAL}, {CHOICE_SCR}, {NEWELEM_TYPE}, {NEWELEM_NAME}, replace(replace({NEWELEM_NAME}, ''}'', ''''), ''{'', ''''));
     --
     {PHP_RETURN} := {CHOICE_SCR};
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Dodaj kolejny', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {NEWELEM_BUTTON20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 10, 'NEWELEM_BUTTON20', OPSCR_SEQ.currval, 'BUTTON', '{NEWELEM_BUTTON20}', '', '',
  'case 
     when exists(select 1 
                   from cms_screen_elements elem, 
                        cms_operation_screens scr,
                        cms_operations op
                  where elem.name = {NEWELEM_NAME}
                    and elem.opscr_id = scr.id
                    and scr.op_id = op.id
                    and op.id = {CHOICE_OP})
     then ''Podana nazwa elementu już istnieje''
     when {NEWELEM_TYPE} is null
     then ''Typ elementu jest wymagany''
     when {NEWELEM_NAME} is null
     then ''Nazwa elementu jest wymagany''
     when instr({NEWELEM_NAME}, ''{'') <= 0 or instr({NEWELEM_NAME}, ''}'') <= 0
     then ''Nazwa elementu musi się zaczynać od "{" i kończyć "}"''
     else null
   end',
  'begin
     --
     insert into cms_screen_elements(id, seq, ordinal, opscr_id, type, name, description)
     values(screlem_seq.nextval, screlem_seq.currval, {NEWELEM_ORDINAL}, {CHOICE_SCR}, {NEWELEM_TYPE}, {NEWELEM_NAME}, replace(replace({NEWELEM_NAME}, ''}'', ''''), ''{'', ''''));
     --
     {PHP_RETURN} := screlem_seq.currval;
     {CHOICE_SCR} := {CHOICE_SCR};
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[UPDATE_ELEM]', 'Dalej', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  --------------------------------UPDATE_ELEM-----------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 50, 'UPSERT_OP', '[UPDATE_ELEM]', 'ACTIVE', 'YES', 'YES', 'NO', 'Modyfikajca elementu');
  -- {UPELEM_SCRIPT}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'UPELEM_SCRIPT', OPSCR_SEQ.currval, 'SCRIPT', '{UPELEM_SCRIPT}', '', '',
  '',
  'declare
     cursor c_typ_elem(pp_elem_id varchar2) is
            select * from cms_screen_elements where id = pp_elem_id;
     -- zmienne
     z_elem_id varchar2(50);
     z_screlem cms_screen_elements%rowtype;
   begin 
    --
    z_elem_id := nvl({PHP_RETURN}, {CHOICE_ELEM});
    --
    open c_typ_elem(z_elem_id);
    fetch c_typ_elem into z_screlem;
    close c_typ_elem;
    --
    {ELEM_TYPE}  := z_screlem.type;
    {UPELEM_VAL} := z_screlem.value;
    {UPELEM_STYLE} := z_screlem.style;
    {UPELEM_FCHECK} := z_screlem.function_check;
    {UPELEM_FSQL} := z_screlem.function_sql;
    {UPELEM_FSCR} := z_screlem.function_scr;
    {UPELEM_FVAL} := z_screlem.function_val;
    {UPELEM_FVALB} := z_screlem.function_val_before;
    {UPELEM_FVALA} := z_screlem.function_val_after;
    {UPELEM_FHIDE} := z_screlem.function_hide;
    {UPELEM_GOTOSCR} := z_screlem.gotoscr_id;
    {UPELEM_CLEAR} := z_screlem.clear_field;
    {UPELEM_POSITION} := z_screlem.ordinal;
    --
    {CHOICE_ELEM} := z_elem_id;
    {PHP_RETURN} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {ELEM_TYPE}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'ELEM_TYPE', OPSCR_SEQ.currval, 'VAL', '{ELEM_TYPE}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_LABEL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'UPELEM_LABEL10', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''JS'', ''SCRIPT'', ''TABELA'', ''TABELA_CHECKBOX'', ''LIST'', ''INFO'')
     then ''YES''
     else ''NO''
   end',
  '', 'Wartość domyślna:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_VAL}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'UPELEM_VAL', OPSCR_SEQ.currval, 'TEXT', '{UPELEM_VAL}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''JS'', ''SCRIPT'', ''TABELA'', ''TABELA_CHECKBOX'', ''LIST'', ''INFO'')
     then ''YES''
     else ''NO''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_LABEL20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 5, 'UPELEM_LABEL20', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL20}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Pozycja:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_VAL}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 6, 'UPELEM_VAL', OPSCR_SEQ.currval, 'TEXT', '{UPELEM_POSITION}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_LABEL30}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 7, 'UPELEM_LABEL30', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL30}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''JS'', ''VAL'', ''SCRIPT'')
     then ''NO''
     else ''YES''
   end',
  '', 'Styl elementu:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_STYLE}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 8, 'UPELEM_STYLE', OPSCR_SEQ.currval, 'TEXT', '{UPELEM_STYLE}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''JS'', ''VAL'', ''SCRIPT'')
     then ''NO''
     else ''YES''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_LABEL40}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 9, 'UPELEM_LABEL40', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL40}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', 'Funkcja sprawdzająca:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FCHECK}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB, 
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 10, 'UPELEM_FCHECK', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FCHECK}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  '''Przykład użycia: case when 2!=1 then "Jeden nie jest równe dwa" else null end''');
  -- {UPELEM_LABEL50}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 11, 'UPELEM_LABEL50', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL50}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Funkcja sql:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FSQL}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB,
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 12, 'UPELEM_FSQL', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FSQL}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  'case
     when {ELEM_TYPE} in(''TABELA_CHECKBOX'', ''TABELA'')
     then ''select id id_g, [pozostałe kolumny] from [tabela] [where ...] - id_g oznacza że ta wartość zostanie przypisana do checboxa/radiobutton w tabeli''
     when {ELEM_TYPE} in(''BUTTON'')
     then ''Akcja jaka zostanie wywołana po naciśnięciu przycisku. Przykład zasotsowania declare [deklaracja zmiennych i inncyh] begin [funkcje] end ''
     else null
   end');
  -- {UPELEM_LABEL60}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 13, 'UPELEM_LABEL60', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL60}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'', ''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', 'Funkcja następnego ekranu:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FSCR}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB,
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 14, 'UPELEM_FSCR', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FSCR}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  '''Przykład użycia: case when [warunek] then [nazwa_ekranu] else null end jeżeli funkcja zwróci nam null to obecny ekran zostanie odświeżony w innym przypadku wyświetli się nowy ekran.''');
  -- {UPELEM_LABEL70}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 15, 'UPELEM_LABEL70', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL70}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Funkcja wartości:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FVAL}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 16, 'UPELEM_FVAL', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FVAL}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_LABEL80}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 17, 'UPELEM_LABEL80', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL80}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''INFO'', ''JS'', ''SCRIPT'', ''TABELA_CHECKBOX'', ''TABELA'')
     then ''YES''
     else ''NO''
   end',
  '', 'Funkcja wartości przed ekranem:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FVALB}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB,
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 18, 'UPELEM_FVALB', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FVALB}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''INFO'', ''JS'', ''SCRIPT'', ''TABELA_CHECKBOX'', ''TABELA'')
     then ''YES''
     else ''NO''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  '''Wartość jaka ma być dla danego pola przed wyświetleniem ekranu.''');
  -- {UPELEM_LABEL90}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 19, 'UPELEM_LABEL90', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL90}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''INFO'', ''JS'', ''SCRIPT'', ''TABELA_CHECKBOX'', ''TABELA'')
     then ''YES''
     else ''NO''
   end',
  '', 'Funkcja wartości po ekranie:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FVALA}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB,
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 20, 'UPELEM_FVALA', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FVALA}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''INFO'', ''JS'', ''SCRIPT'', ''TABELA_CHECKBOX'', ''TABELA'')
     then ''YES''
     else ''NO''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  '''Wartość jaka ma być dla danego pola po wyświetleniem ekranu, np jeżeli chcemy poprawić wartość dodać/dopisać jakoś stałą wartość.''');
  -- {UPELEM_LABEL100}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 21, 'UPELEM_LABEL100', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL100}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''SCRIPT'',''JS'', ''VAL'')
     then ''YES''
     else ''NO''
   end',
  '', 'Funkcja ukryj:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_FHIDE}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB,
  TOOLTIP)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 22, 'UPELEM_FHIDE', OPSCR_SEQ.currval, 'TEXTAREA', '{UPELEM_FHIDE}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''SCRIPT'',''JS'', ''VAL'')
     then ''YES''
     else ''NO''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES',
  '''"YES" - element ukryty, "NO" - element widoczny. Przykład case [warunek] then "YES"/"NO"''');
  -- {UPELEM_LABEL110}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 23, 'UPELEM_LABEL110', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL110}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', 'Następny ekran:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_GOTOSCR}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 24, 'UPELEM_GOTOSCR', OPSCR_SEQ.currval, 'LIST', '{UPELEM_GOTOSCR}', '', '',
  '',
  'select name id, description opis from cms_operation_screens where op_id = {CHOICE_OP}',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''BUTTON'',''TABELA_CHECKBOX'', ''TABELA'')
     then ''NO''
     else ''YES''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_LABEL120}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 25, 'UPELEM_LABEL120', OPSCR_SEQ.currval, 'LABEL', '{UPELEM_LABEL120}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''TEXT'',''TEXTAREA'', ''NUMBER'')
     then ''NO''
     else ''YES''
   end',
  '', 'Czy czyścić wartość pola?', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_CLEAR}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 26, 'UPELEM_CLEAR', OPSCR_SEQ.currval, 'LIST', '{UPELEM_CLEAR}', '', '',
  '',
  'select ''No'' id, ''Nie'' opis from dual
    union
   select ''YES'' id, ''Tak'' opis from dual',
  '',
  '',
  '',
  '',
  '',
  'case
     when {ELEM_TYPE} in(''TEXT'',''TEXTAREA'', ''NUMBER'')
     then ''NO''
     else ''YES''
   end',
  '', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_BUTTON10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 27, 'UPELEM_BUTTON10', OPSCR_SEQ.currval, 'BUTTON', '{UPELEM_BUTTON10}', '', '',
  '',
  'begin
     --
     update cms_screen_elements
        set style = {UPELEM_STYLE},
            ordinal = {UPELEM_POSITION},
            function_check = {UPELEM_FCHECK},
            function_sql = {UPELEM_FSQL},
            function_scr = {UPELEM_FSCR},
            function_val = {UPELEM_FVAL},
            function_val_before = {UPELEM_FVALB},
            function_val_after = {UPELEM_FVALA},
            function_hide = {UPELEM_FHIDE},
            gotoscr_id = {UPELEM_GOTOSCR},
            value = {UPELEM_VAL},
            clear_field = nvl({UPELEM_CLEAR}, clear_field)
      where id = {CHOICE_ELEM};
     --
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_ELEM]', 'Zapisz', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_BUTTON20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 28, 'UPELEM_BUTTON20', OPSCR_SEQ.currval, 'BUTTON', '{UPELEM_BUTTON20}', '', '',
  '',
  'begin
     --
     delete from cms_screen_elements
      where id = {CHOICE_ELEM};
     --
     {CHOICE_ELEM} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_ELEM]', 'Usuń', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {UPELEM_BUTTON30}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 29, 'UPELEM_BUTTON30', OPSCR_SEQ.currval, 'BUTTON', '{UPELEM_BUTTON30}', '', '',
  '',
  'begin {CHOICE_ELEM} := null; end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_ELEM]', 'Wybierz element', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  ---------------------------------CHOICE_SCR-----------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 60, 'UPSERT_OP', '[CHOICE_SCR]', 'ACTIVE', 'YES', 'YES', 'NO', 'Wybór ekranu');
  -- {CHOICE_SCRLBL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'CHOICE_SCRLBL10', OPSCR_SEQ.currval, 'LABEL', '{CHOICE_SCRLBL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_ELEM]', 'Lista ekranów:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_SCR}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'CHOICE_SCR', OPSCR_SEQ.currval, 'TABELA', '{CHOICE_SCR}', '', '',
  '',
  'select id id_g, description "Ekran" from cms_operation_screens where op_id = {CHOICE_OP} and state_id = ''ACTIVE''',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_ELEM]', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_SCRBTN10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'CHOICE_SCRBTN10', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_SCRBTN10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[NEW_SCR]', 'Twórz nowy ekran', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_SCRBTN20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'CHOICE_SCRBTN20', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_SCRBTN20}', '', '',
  '',
  'begin
     --
     delete from cms_screen_elements where opscr_id in(select id from cms_operation_screens where op_id = {CHOICE_OP});
     delete from cms_operation_screens where op_id = {CHOICE_OP};
     delete from cms_operation_users where op_id = {CHOICE_OP};
     delete from cms_operations where id = {CHOICE_OP};
     --
     {CHOICE_OP} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_OP]', 'Usuń operacje', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_SCRBTN30}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 5, 'CHOICE_SCRBTN30', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_SCRBTN30}', '', '',
  '',
  'begin 
     {CHOICE_OP} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_OP]', 'Wróć', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  ---------------------------------CHOICE_ELEM----------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 70, 'UPSERT_OP', '[CHOICE_ELEM]', 'ACTIVE', 'YES', 'YES', 'NO', 'Wybór elementu');
  -- {CHOICE_ELEMLBL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'CHOICE_ELEMLBL10', OPSCR_SEQ.currval, 'LABEL', '{CHOICE_ELEMLBL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_ELEM]', 'Lista elementów:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_ELEM}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'CHOICE_ELEM', OPSCR_SEQ.currval, 'TABELA', '{CHOICE_ELEM}', '', '',
  '',
  'select id id_g, description "Element", type "Typ elementu", ordinal "Pozycja"
     from cms_screen_elements 
    where opscr_id = {CHOICE_SCR} 
      and state_id = ''ACTIVE''
    order by ordinal',
  '',
  '',
  '',
  '',
  '',
  '',
  '[UPDATE_ELEM]', '', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_ELEMBTN10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'CHOICE_ELEMBTN10', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_ELEMBTN10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[NEW_ELEM]', 'Twórz nowy element', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_ELEMBTN20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'CHOICE_ELEMBTN20', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_ELEMBTN20}', '', '',
  '',
  'begin
     delete from cms_screen_elements where opscr_id = {CHOICE_SCR};
     delete from cms_operation_screens where id = {CHOICE_SCR};
     --
     {CHOICE_SCR} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_SCR]', 'Usuń ekran', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_ELEMBTN30}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 5, 'CHOICE_ELEMBTN30', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_ELEMBTN30}', '', '',
  '',
  'begin
     {CHOICE_ELEM} := null;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_SCR]', 'Wróć', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  ---------------------------------UPSERT_USER----------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATIONS(ID, SEQ, ORDINAL, NAME, STATE_ID, DESCRIPTION, VERSION)
  values('UPSERT_USER', OP_SEQ.nextval, 0, '[UPSERT_USERS]', 'ACTIVE', 'Przypisywanie użytkownikow do operacji', '<1.0.0>');
  ------------------------------------------------------------------------------
  ----------------------------------CHOICE_OP-----------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 50, 'UPSERT_USER', '[CHOICE_OP]', 'ACTIVE', 'YES', 'YES', 'NO', 'Wybierz operacje do przypisania');
  -- {CHOICE_LBL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'CHOICE_LBL10', OPSCR_SEQ.currval, 'LABEL', '{CHOICE_LBL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Wybierz operacje:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_OPID}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'CHOICE_OPID', OPSCR_SEQ.currval, 'TABELA_CHECKBOX', '{CHOICE_OPID}', '', '',
  '',
  'select id id_g, description "Operacja" from cms_operations where id not in(''UPSERT_OP'', ''UPSERT_USER'') and state_id = ''ACTIVE''',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'YES', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {CHOICE_BTN10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'CHOICE_BTN10', OPSCR_SEQ.currval, 'BUTTON', '{CHOICE_BTN10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[ASSIGN_USER]', 'Przypisz do użytkowników', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  ------------------------------------------------------------------------------
  ----------------------------------ASSIGN_USER-----------------------------------
  ------------------------------------------------------------------------------
  insert into CMS_OPERATION_SCREENS(ID, SEQ, ORDINAL, OP_ID, NAME, STATE_ID, IS_LOGOUT, IS_MENU, IS_NEW_WINDOW, DESCRIPTION)
  values(OPSCR_SEQ.nextval, OPSCR_SEQ.currval, 60, 'UPSERT_USER', '[ASSIGN_USER]', 'ACTIVE', 'YES', 'YES', 'NO', 'Przypisz do użytkownika');
  -- {ASSIGN_LBL10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 1, 'ASSIGN_LBL10', OPSCR_SEQ.currval, 'LABEL', '{ASSIGN_LBL10}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '', 'Wybierz użytkowników:', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {ASSIGN_USERID}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 2, 'ASSIGN_OPID', OPSCR_SEQ.currval, 'TABELA_CHECKBOX', '{ASSIGN_USERID}', '', '',
  '',
  'select id id_g, description "Użytkownik" 
     from cms_users u
    where not exists(select 1 
                       from cms_operation_users 
                      where op_id in(select regexp_substr({CHOICE_OPID}, ''[^,;]+'', 1, level) from dual connect by regexp_instr({CHOICE_OPID}, ''[,;]+'', 1, level - 1) > 0)
                        and user_id = u.id)',
  '',
  '',
  '',
  '',
  '',
  '',
  '', '', 'YES', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {ASSIGN_BTN10}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 3, 'ASSIGN_BTN10', OPSCR_SEQ.currval, 'BUTTON', '{ASSIGN_BTN10}', '', '',
  '',
  'declare
     cursor c_czy_dodac(pp_user_id varchar2, pp_opp_id varchar2) is
            select 1 from cms_operation_users where op_id = pp_opp_id and user_id = pp_user_id;
     
     -- zmienne
     z_op varchar2(50) := {CHOICE_OPID};
     z_user varchar2(50) := {ASSIGN_USERID};
     z_user_tmp varchar2(50);
     z_op_id varchar2(50);
     z_user_id varchar2(50);
     
     z_czy_dodac number;
     z_pos_op number;
     z_pos_user number;
     
   begin
     while z_op is not null loop
           --
           z_pos_op := instr(z_op, '','');
           --
           if z_pos_op > 0 then
              --
              z_op_id := substr(z_op, 1, z_pos_op -1);
              z_op := substr(z_op, z_pos_op + 1, length(z_op));
           else
              --
              z_op_id := z_op;
              z_op := null;
           end if;
           --
           z_user_tmp := z_user;
           --
           while z_user_tmp is not null loop
                 --
                 z_pos_user := instr(z_user_tmp, '','');
                 --
                 if z_pos_user > 0 then
                    --
                    z_user_id := substr(z_user_tmp, 1, z_pos_user -1);
                    z_user_tmp := substr(z_user_tmp, z_pos_user + 1, length(z_user_tmp));
                 else
                    --
                    z_user_id := z_user_tmp;
                    z_user_tmp := null;
                 end if;
                 --
                 open c_czy_dodac(z_user_id, z_op_id);
                      fetch c_czy_dodac into z_czy_dodac;
                 close c_czy_dodac;
                 --
                 if z_czy_dodac is null then
                    insert into cms_operation_users(id, seq, user_id, op_id)
                    values(OPUSER_SEQ.nextval, OPUSER_SEQ.currval, z_user_id, z_op_id);
                 end if;
           end loop;
     end loop;
   end;',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_OP]', 'Zapisz', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
  -- {ASSIGN_BTN20}
  insert into CMS_SCREEN_ELEMENTS(ID, SEQ, ORDINAL, DESCRIPTION, OPSCR_ID, TYPE, NAME, STYLE, CLASS, 
  FUNCTION_CHECK, 
  FUNCTION_SQL, 
  FUNCTION_PROC, 
  FUNCTION_SCR, 
  FUNCTION_VAL, 
  FUNCTION_VAL_BEFORE, 
  FUNCTION_VAL_AFTER,
  FUNCTION_HIDE, 
  GOTOSCR_ID, VALUE, CLEAR_FIELD, IS_ROW, HTML_BEFORE_ELEM, HTML_AFTER_ELEM, STATE_ID, CREATE_DATE, COMMENTS,
  LABEL, REFRESH_CONTENT, REFRESH_SCREEN, CONTAINER_STYLE, NEW_WINDOW, FUNCTION_NEW_WINDOW, NEW_WINDOW_IN_TAB)
  values(SCRELEM_SEQ.nextval, SCRELEM_SEQ.currval, 4, 'ASSIGN_BTN20', OPSCR_SEQ.currval, 'BUTTON', '{ASSIGN_BTN20}', '', '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '[CHOICE_OP]', 'Wróć', 'NO', 'YES', '', '', 'ACTIVE', SYSDATE, '', 
  '', 'NO', 'NO', '', '', '', 'YES');
end;