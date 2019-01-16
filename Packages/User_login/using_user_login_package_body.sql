
set serveroutput on;
set verify off;

declare
  uname varchar2(30) := '&user_name';
  phn number := &phone;
  age number := &age;
  lid location.lnum%TYPE := &lnum;
  pass userinfo.password%TYPE := &pass;
  uid number;
begin
  uid := user_signup_proc.Login_func(uname, phone, lid);
  user_package.user_signup_proc(uname, age, phn, pass, lid);
  if uid <> 0
  then 
    if lid = 1
      show_res_proc_gulshan(uid, lid);
    else
      show_res_proc_khilgaon(uid, lid);
  end if;

end;
/
