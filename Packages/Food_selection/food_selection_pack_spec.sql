create or replace package food_selection_package as 

function search_func_gulshan(fnum in food_type.fnum%type)
   return sys_refcursor ;
   function search_func_khilgaon(fnum in food_type.fnum%type)
    return sys_refcursor;
    procedure show_menu_proc_gulshan(res_id in number);
    procedure show_menu_proc_dhanmondi(res_id in number)

food_selection_package;
/