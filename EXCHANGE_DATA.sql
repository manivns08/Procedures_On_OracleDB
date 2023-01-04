PROCEDURE exchange_data
is
emp_id employee_test.empid%type;
emp_firstname employee_test.firstname%type;
emp_lastname employee_test.lastname%type;
emp_salary employee_test.salary%type;
cursor getdetails is
select empid,firstname,lastname,salary from employee_test;
begin





open getdetails;
loop
fetch getdetails into emp_id,emp_firstname,emp_lastname,emp_salary ;
exit when getdetails%notfound;
dbms_output.put_line(emp_id||' '||emp_firstname||' '||emp_lastname||' '||emp_sal
ary);

--insert into employee_clone(empid,firstname,lastname,salary) values(emp_id,emp_
firstname,emp_lastname,emp_salary);

end loop;
end;
