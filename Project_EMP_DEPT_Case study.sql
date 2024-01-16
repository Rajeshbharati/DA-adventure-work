create database project;
use project;
#---Q2----#
create table dept_table ( deptno int primary key , dname varchar(30), loc varchar(30));
INSERT INTO dept_table VALUES
(10,'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');
select * from dept_table;
# ---Q1---#
 create table employee_table ( empno int ,ename varchar(30), job varchar(30) default "clerk", mgr varchar(30), hiredate date,
 sal decimal(10,2) not null check( sal > 0), comm decimal(10,2) , deptno int , foreign key(deptno) references dept_table(deptno));
INSERT INTO employee_table  VALUES
(7369,'SMITH','CLERK',7902,'1890-12-17',800,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);
select * from employee_table;
#--Q3----#
  select ename ,sal from employee_table where sal > 1000;
  # ---Q4----#
   select * from employee_table where hiredate >'1981-09-08';
     #--Q5---#
   select * from employee_table where ename like "_i%";
    # ----Q6----#.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary.
    #Also assign the alias name for the columns
    select ename ,sal ,(sal/100*40) as allowances , (sal/100*10) as p_f ,((sal/100*40)- (sal/100*10)) as net_salary from employee_table;
      #---Q7---#. List Employee Names with designations who does not report to anybody
   select * from employee_table where mgr is null;
    #----Q8---# List Empno, Ename and Salary in the ascending order of salary.
  select empno , ename ,sal from employee_table   order by sal ;
  #---Q9---# How many jobs are available in the Organization ?
 select job from employee_table group by job;
  select count(job) from employee_table;
  #--10---# Determine total payable salary of salesman category
  select  sum(sal) from employee_table where job ="salesman";
   #---Q11---#	List average monthly salary for each job within each department   
    select deptno ,ename ,job ,avg(sal) as average_salary  from employee_table group by deptno;
    #---Q12---# Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, 
 #SALARY and DEPTNAME in which the employee is working.
 select ename ,sal ,dname from dept_table , employee_table where dept_table.deptno =employee_table.deptno ;
 #--Q13--- #
  create table grade_table ( grade varchar(30), lowest_salary int ,higest_salary int);
  insert into grade_table values ("A", 0 , 999),("B",1000,1999),("C",2000,2999),("D",3000,3999),("E",4000,5000);
  SELECT * FROM GRADE_TABLE;
  #--Q14----#	Display the last name, salary and Corresponding Grade.
  select ename ,sal,grade from employee_table,grade_table where sal between lowest_salary and higest_salary;
  #--Q15--#	Display the Emp name and the Manager name under whom the Employee works in the below format .
# Emp Report to Mgr.
select ename,mgr from employee_table order by empno = mgr;
#  --Q16----#	Display Empname and Total sal where Total Sal (sal + Comm)
select ename ,(sal + comm) as total_salary from employee_table;
select ename,sal+ ifnull(comm,0) as total_salary from employee_table;
#--Q17---#	Display Empname and Sal whose empno is a odd number
select* from employee_table;
select empno , ename , sal from employee_table where mod(empno,2) != 0;
 #--Q18---#	Display Empname , Rank of sal in Organisation , Rank of Sal in their department
 SELECT ENAME,DNAME,
RANK () OVER (ORDER BY SAL DESC) AS RANK_OF_SAL_ORG,
DENSE_RANK () OVER (PARTITION BY DNAME ORDER BY SAL DESC) AS RANK_OF_SAL_DEPT
FROM EMPLOYEE_table,DEPt_table;
#---Q19---#	Display Top 3 Empnames based on their Salary
select ename ,sal from employee_table order by sal desc limit 3;
#---Q20---# Display Empname who has highest Salary in Each Department.
select ename ,job ,max(sal) from employee_table , dept_table group by job ;


  
 
    
    


 

 
 
 
 
