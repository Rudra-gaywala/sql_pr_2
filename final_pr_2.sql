mysql> create table customers (
    -> customer_id int auto_increment primary key,
    -> First_name varchar(20) not null,
    -> Last_name varchar(20) not null,
    -> Email varchar(30) not null,
    -> Registration_date date );
Query OK, 0 rows affected (0.426 sec)

mysql> create table orders (
    -> order_id int auto_increment primary key,
    -> customer_id int not null,
    -> Order_date date not null,
    -> total_amount int not null,
    -> foreign key (customer_id) references customers(customer_id));
Query OK, 0 rows affected (0.426 sec)


mysql> create table employees (
    -> employee_id int auto_increment primary key,
    -> first_name varchar(20) not null,
    -> last_name varchar(20) not null,
    -> department varchar(20) not null ,
    -> hire_date date not null,
    -> salary int not null);
Query OK, 0 rows affected (0.392 sec)

mysql> insert into customers (first_name , last_name , email , registration_date)
    -> values("john" , "doe" , "john.doe@gmail.com" , "2025-07-21"),
    -> ("jane" , "smith" , "jane.smith@gmail.com" , "2025-07-12");
Query OK, 2 rows affected (0.183 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into employees (first_name , last_name , department , hire_date , salary)
    -> values("Mark", "Johnson", "Sales", "2020-01-15", 50000),
    -> ("Susan", "Lee", "HR", "2021-03-20", 5000);
Query OK, 2 rows affected (0.069 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> insert into orders (customer_id , order_date , total_amount)
    -> values(1, "2023-07-01", 150),
    -> (2, "2023-07-03", 200);
Query OK, 2 rows affected (0.144 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select o.order_id , o.order_date , o.total_amount , c.first_name , c.last_name
    -> from orders o
    -> inner join customers c on o.customer_id = c.customer_id;
+----------+------------+--------------+------------+-----------+
| order_id | order_date | total_amount | first_name | last_name |
+----------+------------+--------------+------------+-----------+
|        1 | 2023-07-01 |          150 | john       | doe       |
|        2 | 2023-07-03 |          200 | jane       | smith     |
+----------+------------+--------------+------------+-----------+
2 rows in set (0.073 sec)

mysql> select c.customer_id , c.first_name , c.last_name , o.order_id , o.total_amount
    -> from customers c
    -> left join orders o on c.customer_id = o.customer_id;
+-------------+------------+-----------+----------+--------------+
| customer_id | first_name | last_name | order_id | total_amount |
+-------------+------------+-----------+----------+--------------+
|           1 | john       | doe       |        1 |          150 |
|           2 | jane       | smith     |        2 |          200 |
+-------------+------------+-----------+----------+--------------+
2 rows in set (0.031 sec)

mysql> select c.customer_id , c.first_name , c.last_name , o.order_id , o.total_amount
    -> from customers c
    -> right join orders o on c.customer_id = o.customer_id;
+-------------+------------+-----------+----------+--------------+
| customer_id | first_name | last_name | order_id | total_amount |
+-------------+------------+-----------+----------+--------------+
|           1 | john       | doe       |        1 |          150 |
|           2 | jane       | smith     |        2 |          200 |
+-------------+------------+-----------+----------+--------------+
2 rows in set (0.009 sec)

mysql> select c.customer_id , c.first_name , c.last_name , o.order_id , o.total_amount
    -> from customers c
    -> left join orders o on c.customer_id = o.customer_id
    -> union
    -> select c.customer_id , c.first_name , c.last_name , o.order_id , o.total_amount
    -> from customers c
    -> right join orders o on c.customer_id = o.customer_id;
+-------------+------------+-----------+----------+--------------+
| customer_id | first_name | last_name | order_id | total_amount |
+-------------+------------+-----------+----------+--------------+
|           1 | john       | doe       |        1 |          150 |
|           2 | jane       | smith     |        2 |          200 |
+-------------+------------+-----------+----------+--------------+
2 rows in set (0.115 sec)

mysql> select distinct c.*
    -> from customers c
    -> join orders o on c.customer_id = o.customer_id
    -> where o.total_amount > (select avg(total_amount) from orders);
+-------------+------------+-----------+----------------------+-------------------+
| customer_id | first_name | last_name | email                | registration_date |
+-------------+------------+-----------+----------------------+-------------------+
|           2 | jane       | smith     | jane.smith@gmail.com | 2025-07-12        |
+-------------+------------+-----------+----------------------+-------------------+
1 row in set (0.079 sec)

mysql> select * from employees where salary > (select avg(salary) from employees);
+-------------+------------+-----------+------------+------------+--------+
| employee_id | first_name | last_name | department | hire_date  | salary |
+-------------+------------+-----------+------------+------------+--------+
|           1 | Mark       | Johnson   | Sales      | 2020-01-15 |  50000 |
+-------------+------------+-----------+------------+------------+--------+
1 row in set (0.017 sec)

mysql> select order_id , year(order_date) as OrderYear , month(order_date) as OrderMonth
    -> from orders;
+----------+-----------+------------+
| order_id | OrderYear | OrderMonth |
+----------+-----------+------------+
|        1 |      2023 |          7 |
|        2 |      2023 |          7 |
+----------+-----------+------------+
2 rows in set (0.033 sec)

mysql> select order_id , datediff(curdate() , order_date) as DaysDiffrence
    -> from orders;
+----------+---------------+
| order_id | DaysDiffrence |
+----------+---------------+
|        1 |           774 |
|        2 |           772 |
+----------+---------------+
2 rows in set (0.037 sec)

mysql> select order_id , date_format(order_date , "%d-%b-%Y") as FormattedDate
    -> from orders;
+----------+---------------+
| order_id | FormattedDate |
+----------+---------------+
|        1 | 01-Jul-2023   |
|        2 | 03-Jul-2023   |
+----------+---------------+
2 rows in set (0.034 sec)

mysql> select concat("first_name" , " " , "last_name") as FullName
    -> from customers;
+----------------------+
| FullName             |
+----------------------+
| first_name last_name |
| first_name last_name |
+----------------------+
2 rows in set (0.024 sec)

mysql> select concat(first_name , " " , last_name) as FullName
    -> from customers;
+------------+
| FullName   |
+------------+
| john doe   |
| jane smith |
+------------+
2 rows in set (0.017 sec)

mysql> select replace (first_name , "john" , "jonathan") as UpdatedFirstName , last_name
    -> from customers;
+------------------+-----------+
| UpdatedFirstName | last_name |
+------------------+-----------+
| jonathan         | doe       |
| jane             | smith     |
+------------------+-----------+
2 rows in set (0.021 sec)

mysql> select upper(first_name) as UpperFirstName , lower(last_name) as LowerLastName
    -> from customers;
+----------------+---------------+
| UpperFirstName | LowerLastName |
+----------------+---------------+
| JOHN           | doe           |
| JANE           | smith         |
+----------------+---------------+
2 rows in set (0.027 sec)

mysql> select trim(email) as CleanEmail
    -> from customers;
+----------------------+
| CleanEmail           |
+----------------------+
| john.doe@gmail.com   |
| jane.smith@gmail.com |
+----------------------+
2 rows in set (0.012 sec)

mysql> select order_id , order_date , total_amount , sum(total_amount) over (order by order_date) as RunningTotal
    -> from orders;
+----------+------------+--------------+--------------+
| order_id | order_date | total_amount | RunningTotal |
+----------+------------+--------------+--------------+
|        1 | 2023-07-01 |          150 |          150 |
|        2 | 2023-07-03 |          200 |          350 |
+----------+------------+--------------+--------------+
2 rows in set (0.065 sec)

mysql> select order_id , total_amount , rank() over (order by total_amount desc) as OrderRank
    -> from orders;
+----------+--------------+-----------+
| order_id | total_amount | OrderRank |
+----------+--------------+-----------+
|        2 |          200 |         1 |
|        1 |          150 |         2 |
+----------+--------------+-----------+
2 rows in set (0.021 sec)

mysql> select order_id , total_amount ,
    -> case
    -> when total_amount > 1000 then "10% off"
    -> when total_amount > 500  then "5% off"
    -> else "No Discount"
    -> end as discount
    -> from orders;
+----------+--------------+-------------+
| order_id | total_amount | discount    |
+----------+--------------+-------------+
|        1 |          150 | No Discount |
|        2 |          200 | No Discount |
+----------+--------------+-------------+
2 rows in set (0.017 sec)

mysql> select employee_id , first_name , last_name , salary,
    -> case
    -> when salary>= 50000 then "High"
    -> when salary >= 20000 then "Medium"
    -> else "Low"
    -> end as SalaryCategory
    -> from employees;
+-------------+------------+-----------+--------+----------------+
| employee_id | first_name | last_name | salary | SalaryCategory |
+-------------+------------+-----------+--------+----------------+
|           1 | Mark       | Johnson   |  50000 | High           |
|           2 | Susan      | Lee       |   5000 | Low            |
+-------------+------------+-----------+--------+----------------+
2 rows in set (0.011 sec)

mysql>