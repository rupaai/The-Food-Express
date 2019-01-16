CREATE OR REPLACE PACKAGE BODY user_package AS 
    procedure user_signup_proc(
      name in userInfo.uname%TYPE,
      age in userInfo.age%TYPE,
      phone in userInfo.phone%TYPE,
      pass in userInfo.pass%TYPE,
      location in location.lname%TYPE)
      IS
      num userinfo.unum%TYPE := 0;
      lnum number;

begin
   lnum = check_lnum_func(location);
   case 
      when lnum = 1
      then
         SELECT max(unum) into num from user1@site_gulshan;
         num := num + 1 ;  
         insert into user1@site_gulshan(unum, uname, age, phone, pass, lnum) values (num, name, age, phone, pass, lnum);
      when lnum = 2 
      then 
         SELECT max(unum) into num from user2@site_khilgaon;
         num := num + 1 ;  
         insert into user2@site_khilgaon(unum, uname, age, phone, pass, lnum) values (num, name, age, phone, pass, lnum);
      else
         dbms_output.put_line('nothing found');
      end case;
   
    commit;
    dbms_output.put_line('Congratulations ' || name || '!!! your account has been created successfully');
    when lnum = 1
        then
            show_res_proc_gulshan(unum, lnum);
            when lnum = 2 
        then 
            show_res_proc_khilgaon(unum, lnum);
        else
            dbms_output.put_line('nothing found');
        end case;
end user_signup_proc;
/




   procedure Login_proc(user_name in userinfo.uname%type,user_phn in userinfo.phone%type, lnum in location.lnum%TYPE)
   is

  cursor cur_g is
   select unum, uname,age,phone from user1@site_gulshan;
  --cursor cur_k is
  --select unum, uname,age,phone from user1@site_khilgaon;
  cur1 cur_g%rowtype;
  --cur2 cur_k%rowtype;
   begin
    if lnum = 1
    then  
    dbms_output.put_line('your location is Gulshan');
    open cur_g;
    loop
      fetch cur_g into cur1;
      exit when cur_g%notfound;
      --dbms_output.put_line(name2);
         if cur1.uname = user_name
            then 
              if cur1.phone = user_phn
                  then
                        dbms_output.put_line('successful login');
                        return cur1.unum;
                        exit;
                 end if; 
         
      end if;  
    end loop;
    close cur_g;  
  else if lnum = 2
    then
    dbms_output.put_line('your location is Khilgaon');
    open cur_k;
      loop
      fetch cur_k into cur2;
      exit when cur_g%notfound;
        --dbms_output.put_line(name2);
        if cur2.uname = user_name
            then 
              if cur2.phone = user_phn
                then
                    dbms_output.put_line('successful login');
                    return cur2.unum;
                    exit;
              end if; 
        
        end if;  
    end loop;
    close cur_k;
    else
      dbms_output.put_line('no such record found!');
  end if;
    commit;
end Login_proc;
/