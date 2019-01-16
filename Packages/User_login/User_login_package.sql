CREATE OR REPLACE PACKAGE user_package AS 

   procedure user_signup_proc(
      name in userInfo.uname%TYPE,
      age in userInfo.age%TYPE,
      phone in userInfo.phone%TYPE,
      pass in userInfo.pass%TYPE,
      location in location.lname%TYPE);
   
   procedure Login_func(user_name in userinfo.uname%type,user_phn in userinfo.phone%type, lnum in location.lnum%TYPE) 

 
END user_package; 