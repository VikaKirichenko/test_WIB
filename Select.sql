-- task A (какую сумму в среднем в месяц тратит):
-- 1 - пользователи в возрасте 18-25
select *
from (users u 
	join purchases p on u.user_id = p.user_id
	join items i on p.item_id = i.item_id)
	where age>=35

select avg(s) from (
	select date_trunc('month', date) as date, sum(price) as s
	from (users u 
	join purchases p on u.user_id = p.user_id
	join items i on p.item_id = i.item_id)
	where 18<=age and age<=25
	group by date) 
as tbl;

-- 2 - пользователи в возрасте 26-35
select avg(s) from (
	select date_trunc('month', date) as date, sum(price) as s
	from (users u 
	join purchases p on u.user_id = p.user_id
	join items i on p.item_id = i.item_id)
	where 26<=age and age<=35
	group by date) 
as tbl;


-- task B 
select to_char(p."date", 'MM') as month_date, sum(i.price)
	from users u 
	join purchases p on u.user_id = p.user_id
	join items i on p.item_id = i.item_id
	where 35<=age
	group by to_char(p."date", 'MM')
	order by sum(i.price) desc
	limit 1;


-- task C 
select i.item_id , sum(i.price)  
	from purchases p
	join items i on p.item_id = i.item_id
	where date >= date_trunc('month', (now() - interval '1 year'))       
	and date <= now()
	group by i.item_id 
	order by sum(i.price) desc
	limit 1;


--task D
(select i.item_id as id, sum(price) as sum_price, sum(price)*100/(select sum(sum_price) as s from
															(select i.item_id as id, sum(price) as sum_price
															from purchases p
															join items i on p.item_id = i.item_id
															where to_char(p."date", 'YYYY') = '2022'
															group by i.item_id 
															) as tbl) as perc
	from purchases p
	join items i on p.item_id = i.item_id
	where to_char(p."date", 'YYYY') = '2022'
	group by i.item_id 
	order by sum(i.price) desc
	limit 3);


















