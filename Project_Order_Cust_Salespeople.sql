create  database project_1;
use project_1;
#--Q1--#
create table salespeople_table ( salespeople_num int primary key , salespeople_name varchar(30),city varchar(30) ,comm decimal(10,2));
insert into salespeople_table values 
(1001,'Peel','London',0.12),
(1002,'Serres','San Jose',0.13),
(1003,'Axelrod','New York',0.10),
(1004,'Motika','London',0.11),
(1007,'Rafkin','Barcelona',0.15);
 select * from salespeople_table;
 
 #--Q2---#
create table cus_table (cus_num int primary key ,cus_name varchar(30) , city varchar(30) , rating varchar(30)  , salespeople_num int,
foreign key(salespeople_num) references salespeople_table(salespeople_num));

INSERT INTO CUS_TABLE VALUES
(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Pereira','Rome',100,1004),
(2008,'James','London',200,1007);

select * from cus_table;
#--Q3--#
create table order_table ( order_num int , amt decimal(10,2) , order_date date , cus_num int , salespeople_num int,
foreign key(cus_num) references cus_table(cus_num) , foreign key(salespeople_num) references salespeople_table(salespeople_num));
insert	into order_table values 
(3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);
select * from order_table;
select column_name, constraint_name from information_schema.key_column_usage where table_name = "order_table";
desc salespeople_table;
desc cus_table;
desc order_table;
# ---Q4--# Write a query to match the salespeople to the customers according to the city they are living.
select salespeople_name , cus_name  , salespeople_table.city from salespeople_table ,cus_table where salespeople_table.city = cus_table.city;

#---Q5---# Write a query to select the names of customers and the salespersons who are providing service to them.
select cus_name,salespeople_name from cus_table,salespeople_table where cus_table.salespeople_num=salespeople_table.salespeople_num;

#---Q6--# Write a query to find out all orders by customers not located in the same cities as that of their salespeople
select order_num , cus_name , order_table.cus_num  , order_table.salespeople_num from salespeople_table , cus_table , order_table 
where salespeople_table.city <> cus_table.city
and order_table.cus_num = cus_table.cus_num 
and order_table.salespeople_num = salespeople_table.salespeople_num;

#---Q7---#.Write a query that lists each order number followed by name of customer who made that order
select order_num , cus_name from order_table , cus_table where order_table.cus_num = cus_table.cus_num;

#----Q8---#.Write a query that finds all pairs of customers having the same rating.
select * from cus_table order by rating;

#-Q9-# Write a query to find out all pairs of customers served by a single salesperson.
select salespeople_table.salespeople_name, cus_table.cus_name from salespeople_table,cus_table 
where cus_table.salespeople_num = salespeople_table.salespeople_num ;

#-Q10-#.Write a query that produces all pairs of salespeople who are living in same city………………..
select salespeople_num ,salespeople_name ,city from salespeople_table order by city;

#----Q11-------.Write a Query to find all orders credited to the same salesperson who services Customer 2008
select order_num from order_table where salespeople_num in ( select salespeople_num from order_table where cus_num = 2008);

#--Q12--#Write a Query to find out all orders that are greater than the average for Oct 4th

select order_num from order_table where amt > (select avg(amt)
from order_table where order_date = "1994-10-04" group by order_date);

#--Q13--#.Write a Query to find all orders attributed to salespeople in London.
select o.order_num from order_table o inner join salespeople_table s on o.salespeople_num = s.salespeople_num  where s.city ="london";

#-Q14-#.Write a query to find all the customers whose cnum is 1000 above the snum of Serres.
select CUS_NUM,CUS_NAME from cus_table
where cus_num > (select salespeople_num from salespeople_table where salespeople_name = 'Serres') + 1000;
SELECT A.CUS_NUM,A.CUS_NAME,B.SALESPEOPLE_NUM,B.SALESPEOPLE_NAME FROM CUS_TABLE A,SALESPEOPLE_TABLE B WHERE B.SALESPEOPLE_NUM+1000>A.CUS_NUM;

#-Q15-#.Write a query to count customers with ratings above San Jose’s average rating.
select city, avg(rating) as avg_rating, count(*) from cus_table
group by city having avg_rating > avg(rating) ;

#-Q16-#.Write a query to show each salesperson with multiple customers.
select a.salespeople_num , a.salespeople_name,count(*) as cus_count from salespeople_table a
inner join cus_table b 
on a.salespeople_num = b.salespeople_num
group by a.salespeople_num having cus_count > 1;








 
     





