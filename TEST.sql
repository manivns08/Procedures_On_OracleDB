procedure test
is

  l_object_type   VARCHAR2(30) := 'PROCEDURE';
  l_name	  VARCHAR2(30);
  l_ddl 	  CLOB;
  l_directory	  VARCHAR2(30) := 'MY_DIR';
  l_file	  VARCHAR2(30);
  l_file_handle   UTL_FILE.file_type;
  l_buffer	  VARCHAR2(32767);
  l_buffer_size   BINARY_INTEGER := 32767;
  l_amount	  BINARY_INTEGER;
  l_offset	  NUMBER := 1;
  l_crlf	  VARCHAR2(2) := chr(13) || chr(10);
  l_sql 	  VARCHAR2(1000);

  CURSOR c_objects IS
    SELECT object_name
    FROM user_objects
    WHERE object_type = l_object_type;
begin

  FOR r_objects IN c_objects LOOP
    l_name := r_objects.object_name;
    l_ddl := dbms_metadata.get_ddl(l_object_type, l_name);
    l_file := l_name || '.sql';
    l_file_handle := UTL_FILE.fopen(l_directory, l_file, 'w', 32767);
    l_amount := length(l_ddl);
    WHILE l_amount > 0 LOOP
      l_buffer := SUBSTR(l_ddl, l_offset, l_buffer_size);
      UTL_FILE.put_line(l_file_handle, l_buffer || l_crlf);
      l_offset := l_offset + l_buffer_size;
      l_amount := l_amount - l_buffer_size;
    END LOOP;
    UTL_FILE.fclose(l_file_handle);
  END LOOP;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
