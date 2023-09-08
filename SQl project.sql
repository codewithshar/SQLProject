create database sql_project;
use sql_project; #it is create so we used same database again and again without create a database again 
CREATE TABLE salary (
	Organization_Group_Code DECIMAL(38, 0) NOT NULL, 
	Job_Family_Code VARCHAR(14) NOT NULL, 
	Job_Code VARCHAR(4) NOT NULL, 
	Year_Type VARCHAR(8) NOT NULL, 
	`Year` DECIMAL(38, 0) NOT NULL, 
	Organization_Group VARCHAR(40) NOT NULL, 
	Department_Code VARCHAR(3), 
	Department VARCHAR(30), 
	Union_Code DECIMAL(40, 4), 
	`Union` VARCHAR(50), 
	Job_Family VARCHAR(30) NOT NULL, 
	Job VARCHAR(40), 
	Employee_identifier DECIMAL(38, 0) NOT NULL, 
	Salaries DECIMAL(38, 2) NOT NULL, 
	Overtime DECIMAL(38, 2) NOT NULL, 
	Other_Salaries DECIMAL(38, 2) NOT NULL, 
	Total_Salary DECIMAL(38, 2) NOT NULL, 
	Retirement DECIMAL(38, 2) NOT NULL, 
	Health_and_Dental DECIMAL(38, 2) NOT NULL, 
	Other_Benefits DECIMAL(38, 2) NOT NULL, 
	Total_Benefits DECIMAL(38, 2) NOT NULL, 
	Total_Compensation DECIMAL(38, 2) NOT NULL
);

#----------to see whole data-----------
select * from salary; 

#-----for solve safe mode error------
set session sql_mode=' ';  

# -------TO LOAD DATA IN A BULK----------
load data infile'D:/salary.csv'
into table salary 
fields terminated by','
enclosed by'"'
lines terminated by'\n'
ignore 1 rows;

#---------- to see whole data--------------
select * from salary; # to see whole data;

#-------- to see particular column ------------
select salaries from salary ;

# -----------if i want to starting 10---------- 
select * from salary limit 10;

#-------max salary----------------- 
select  max(salaries) from salary ;

#----------min salary -------------
select min(salaries) from salary;

#--------------if i want sum of salaries------------
select sum(salaries) from salary;

#------------if i want the average salary----------- 
select avg(salaries) from salary;

#----------arrange the data in ascending and descending order------------ 
select * from salary order by job_code;
select * from salary  order by job_code desc;

#-------if i want to know how many type of department-CODE available in this coloumn------- 
select distinct department_code from salary ;

#------- idf i want to extract a data where department_code ='puc'and salaries >8000-----
select * from salary where department_code ='puc'and salaries >8000;

#--------if you want to count particular column ------
select distinct count(organization_group) from salary;

#--------as(aliasing)--------
select count(organization_group) as no_of_grp from salary;

#---max(salaries) which is not earning----
select max(salaries )  as most_earning from salary;
select * from salary where salaries<30000 and job ='storekeeper';

#if we want a list where name of department_code starts with s 
select * from salary where department_code like 'S%';

#------------------for count-----------
select count(department_code) from salary;
# -------------for distincit count------------------
select count( distinct department_code) from salary; 
 
 #-----------------------------------------group by----------------------------
select * from salary;
select department_code, job_code,`year`,union_code ,count(department_code)
as code_of_conduct from salary 
group by 1,2,3,4; #(group by  department_code, job_code,`year`,union_code)

#-----------------use of where clause in group by--------------- 
select department_code, job_code,`year`,union_code ,count(department_code)
as code_of_conduct from salary 
where `year`<2020 
group by 1,2,3,4;

#-----------USE OF GROUPBY WITH NUMBERS---------
select`year`,count(`year`)as year_issue  from salary
group by 1;
#-------------for count with group by--------------
select department_code, count(*) from salary
group by department_code;

#-------------------------------------ORDER BY---------------------------------
select Employee_identifier,salaries, overtime  from salary
where Employee_identifier >10000 
order by 1,2,3;

# ---------for highest----------- 
select * from salary where Department_code = 'PUC'
order by job_code desc limit 1;

#----------------------------------------joins-------------------------------------------
create table employee1(
employeeid int,
firstname varchar(40),
lastname varchar(40),
age int ,
gender varchar(30));
#------- insert values into table ----------------
INSERT INTO employee1 values 
(101,'ashu' ,'sharma', 30,'male' ),
(102,'ayushi','singh',30,'female'),
(103,'abhishek', 'sharma',29,'male'),
(104,'neha','mishra',34,'female'),
(105,'ashish','sharma',43,'male'),
(106,'ashish','raghav',34,'male'),
(107,'golu','sharma',45,'male'),
(108,'shivani','sahu',23,'female'),
(109,'saurav','singh',54,'male'),
(111,'naveen','singgh',45,'male'),
(null,'holly','flax',null,null),
(113,'ryan','goyal',null,'male');

create table employee2(
employeeid int ,
job_title varchar(40),
salary int);
#-------------insert values in tables--------------------
INSERT INTO employee2 values 
(101, 'accountant',100000),
(102, 'salesmen',19000),
(103, 'null',14000),
(104, 'salesmen',10000),
(105, 'supplier_retailer',20000),
(106, 'accountant',19000),
(107, 'Hr',13000),
(108, 'receptionist',10000),
(109, 'salesmen',150000),
(110, null ,10000),
(null, 'data_a',2000);
#----------see whole table-------------
select * from employee1;
select * from employee2;
#----inner join( it shows us the common between two tables intersection btw table A and B)----
select * from employee1
inner join employee2 
on employee1.employeeid= employee2.employeeid;

# ------inner join it shows us only selected columns-----------
select employee1.employeeid,firstname,lastname,job_title,salary
 from employee1
inner join employee2 
on employee1.employeeid= employee2.employeeid;
#---------left outer join-----------------------------
select  * from employee1
left outer join employee2 
on employee1.employeeid= employee2.employeeid;
#-------------left outer join for selected columns-------------------------
 select employee1.employeeid,firstname,lastname,job_title,salary
 from employee1 #this is our left table
 left outer  join employee2  
on employee1.employeeid= employee2.employeeid;
#------------------------------------------right outer join-------------------------------- 
select* from employee1
right outer join employee2
on employee1.employeeid= employee2.employeeid;
#right outer join  for seelecteed columns
select employee1.employeeid ,firstname,lastname,job_title,salary from employee2
right outer join employee1
on employee1.employeeid= employee2.employeeid;

#------------------------------------------unions------------------------------
select employeeid,firstname from employee1
union # it join table vertically ,it removes duplicates
select employeeid , job_title from employee2
order by employeeid;

#-----------------------------------------union all-----------------------
select employeeid,firstname from employee1
union all# it join table vertically ,it doesn'tremoves duplicates
select employeeid , job_title from employee2;
#--------------------------------------------case statament----------------------------------------------
select firstname,lastname,age as age_known,
case 
WHEN age>30 then 'old'
Else 'young' 
End as age_known 
from employee1
where age is not null
order by age ;
select * from employee2;
# Q1 we want to give some appraisal to salesman(.08) ,accountant(.05) else .03 
select firstname,lastname,job_title,salary,
case 
when job_title='salesmen' then salary+(salary *.08)
when job_title='accountant' then salary+(salary *.05)
else salary +(salary*.03)
end as salary_appraisal
from employee1
join employee2
on employee1.employeeid= employee2.employeeid;
#------------------having clause (always use having clause after group by statement)-------------------
select job_title, count(job_title)  as no_of_jobs
from employee1
join employee2 
on employee1.employeeid= employee2.employeeid
group by job_title
having count(job_title)>1;

#------------------having clause with group by and order by-------------------
select salary, avg(salary)  as avg_salary
from employee1
join employee2 
on employee1.employeeid= employee2.employeeid
group by salary
having avg(salary)
order by avg(salary);

#--------------------------updating the data-----------------------------
select * from employee1;
update employee1
set employeeid=112
where firstname='holly'and lastname='flax';
set sql_safe_updates=0;# this is for safe mode method 
#or 
update employee1
set age=34,gender ='female'
where firstname='holly' and lastname = 'flax';
#------------------------------------------------ALIASING---------------------------------------
# 0N COLUMN  
SELECT firstname fname
from employee1;
#or 
select firstname as fname
from employee1 ;
#on column 
select emp1.employeeid	 ,emp2.salary
from employee1 as emp1
join employee2 as emp2
on emp1.employeeid=emp2.employeeid;
select * from emp1;
select * from employee1 
join employee2 
on employee1.employeeid=employee2.employeeid;
#---------------------------------------partition by----------------------------- 
select firstname, lastname, salary,gender, 
count(gender) over (partition by gender) as total_gender 
from  employee1 as emp1
join employee2 as emp2
on emp2.employeeid=emp2.employeeid;
# another query 
select firstname,lastname,gender, salary,
count(gender)over(partition by gender) as Totalgender,
avg(salary) over(partition by salary) as avg_salary
from employee1 as emp1
join employee2 as emp2
on emp1.employeeid=emp2.employeeid;
#-------------------------------CTE--------------------
with CTE_employee as (select firstname,lastname,gender,salary,age,
count(gender) over(partition by gender) as total_gender,
avg(salary) over(partition by salary) as Avg_salary 
from employee1 as emp1
join employee2 as emp2
on emp1.employeeid=emp2.employeeid
where salary<15000
)
select *
from CTE_employee;
#--------------------------------temp table (temporary)-----------
create table temp_employe(
emp_id int,
jobtitle varchar(30),
salary int
);
insert into temp_employe select * from employee2;
select * from temp_employe;
#---------string functions---------------------------------
create table employee_errors(
emp_id int,
firstname varchar(30),
lastname varchar(30));
insert into employee_errors values 
('1','harry','potter'),
('  2','emma','watsn'),
('3','hagrid','bufe');
select * from employee_errors;
#--------trim it keep numbers in middle------
select emp_id , trim(emp_id) as IDTRIM 
FROM employee_errors;
#--------------LTRIM it keep all data into left-----
select emp_id , Ltrim(emp_id) as IDTRIM 
FROM employee_errors;
#--------------RTRIM it keep all data into right-----
select emp_id , Rtrim(emp_id) as IDTRIM 
FROM employee_errors;
#-----------------------------------subqueries------------
#subquery with select statement
select employeeid, salary,(select avg(salary) from employee2) as All_AVG_SALARY
FROM employee2;
#subqueries by partition by 
select employeeid,salary, avg(salary) over() as ALL_AVG_SALARY 
FROM employee2;
