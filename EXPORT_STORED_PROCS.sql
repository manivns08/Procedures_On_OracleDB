PROCEDURE export_stored_procs IS
  v_file utl_file.file_type;
  CURSOR cur_procs IS
    SELECT object_name
    FROM all_procedures
    WHERE object_type = 'PROCEDURE';
  v_filename VARCHAR2(200);
BEGIN
  FOR r_procs IN cur_procs LOOP
    v_filename := r_procs.object_name || '.sql';
    v_file     := utl_file.fopen('STORED_PROCEDURES', v_filename, 'W');
    utl_file.put_line(v_file, r_procs.text);
    utl_file.fclose(v_file);
  END LOOP;
END;
