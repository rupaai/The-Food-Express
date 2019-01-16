-- 3 features
-- t denotes theta
-- h(x) = t1 + t2*x2 + t3*x3 + t4*x4
-- j(t) = 1/2*cnt * sum((h(x) - y)^2)
-- diff_sqr = sum(h(x) - y)
-- so, diff^n(j(t)) = 1/cnt * diff_sqr
-- cost_func = diff^n(j(t))
-- optimization for t1, t2, t3, t4
-- t = t - cost_func

set serveroutput on;
create or replace procedure quality_linear_reg_func(p in number, d in number, 
r in number) 
is

t1 number;
t2 number;
t3 number;
t4 number;
hyp number;

res_id number;
price number;
duration number;
rating number;
quality number;
cursor cur is select res_id, price, duration, rating, quality from quality_prediction;
cost_func number;
dif_sqr number;
cnt number;
alpha number;
iter number;
feat number;

predict_quality number;
begin
	iter := 2;
	t1 := 0;
	t2 := 0;
	t3 := 0;
	t4 := 0;
	feat := 0;
	dif_sqr := 0;
	cnt := 0;
	alpha := 0.005;
	for i in 1..iter loop
		open cur;
		fetch cur into res_id, price, duration, rating, quality;
		loop
			exit when cur%notfound;
			cnt := cnt + 1;
			hyp := t1 + t2 * price + duration* t3 + rating * t4;
			-- sum of (h(x) - y)
			dif_sqr := dif_sqr + (hyp - quality);
		end loop;
		close cur;
		
		cost_func := dif_sqr/cnt;
		cost_func := alpha * cost_func;

		-- optimization 
		t1 := t1 - cost_func;
		t2 := t2 - cost_func;
		t3 := t3 - cost_func;
		t4 := t4 - cost_func;

	end loop;
		

	predict_quality := t1 + t2*p + t3*d + t4*r;

	DBMS_OUTPUT.PUT_LINE('Predicted Quality of the Restaurant is  '|| predict_quality ||' when price = '|| p ||', time = '|| d ||', rating = '|| r);
end;
/


