create database Meow12  -- create is a reserved word for creating any table, database
go
use Meow12
go
-- create table dept
create table dept (
dno int primary key,
dname varchar(5)
);

drop table Student  -- drop is a reserved word

create table Student (
rno int primary key,
fname varchar(20),
lname varchar(20),
age int, 
gender char check(gender = 'M' OR gender = 'F'),
cgpa decimal(2,1) check(cgpa >= 0.00 OR cgpa <= 4.00),
dno int
);

drop table Teacher

create table Teacher (
teacherid int primary key,
tfname varchar(20),
tlname varchar(20),
age int, 
gender char check(gender = 'M' OR gender = 'F'),
coursename varchar(10),
deptno int
);

-- Insert into department table
insert into dept values (10, 'CS')
insert into dept values (20, 'CV')
insert into dept values (30, 'EE')
insert into dept values (40, 'MT')
insert into dept values (50, 'MGT')

-- Insert into Student
insert into Student values (100, 'Hammad', 'Rashid', 20, 'M', 3.8, 10)
insert into Student values (200, 'Zarin', 'Taufique', 21, 'F', 3.9, 10)
insert into Student values (300, 'Ali', 'Haider', 21, 'M', 3.2, 30)
insert into Student values (400, 'Sidra', 'Malik', 20, 'F', 2.4, 40)
insert into Student values (500, 'Aslam', 'Khan', 18, 'M', 2.6, 50)
insert into Student values (600, 'Musira', 'Khan', 19, 'F', 3.1, 50)
insert into Student values (700, 'Ahsan', 'Mehmood', 22, 'M', 1.5, 40)
insert into Student values (800, 'Zeenia', 'Bakhtawar', 24, 'F', 1.9, 30)

-- Insert into Teacher table
insert into Teacher values (1, 'Sarim', 'Baig', 38, 'M', 'DSA', 10)
insert into Teacher values (2, 'Huma', 'Khan', 34, 'F', 'OB', 40)
insert into Teacher values (3, 'Ishaq', 'Raza', 49, 'M', 'DBMS', 10)
insert into Teacher values (4, 'Raheela', 'Tariq', 55, 'F', 'Psy', 40)

-- Select data columns from tables
Select * from dept
Select * from Student
Select * from Teacher

-- adding column in table using alter statement
alter table Student 
add dno int

-- adding foreign key using alter statement
alter table Student
add constraint fk_dno foreign key(dno) references dept(dno) on delete cascade on update cascade

-- adding foreign key
alter table Teacher
add constraint fk_deptno foreign key(deptno) references dept(dno) on delete cascade on update cascade

-- where dname is CS
Select * from dept
where dname = 'CS'

-- where dname has first letter M
Select * from dept
where dname LIKE 'M%'

-- where lname is Khan
Select * from Student
where lname = 'Khan'

-- where cgpa is between 2 and 3 exclusive
Select * from Student where cgpa > 2 AND cgpa < 3

-- order by dno in ascending order
Select * from Student
order by dno asc

-- order by cgpa in descending order
Select * from Student
order by cgpa desc

-- some attributes where coursename has M in it somewhere
Select teacherid, tfname, tlname, coursename
from Teacher where coursename LIKE '%M%'

-- Distinct deptno in Student table
Select DISTINCT(dno) from Student

-- Aggregate functions
Select count(*) AS Total, max(cgpa) as MaxCGPA, min(cgpa) AS MinCGPA, avg(cgpa) AS AVGCGPA from Student group by gender
Select count(Distinct(dno)) AS [Dept in Student Table] from Student

Select rno, fname, lname, gender, age, cgpa, dno, (dno + 10) AS [Updated Dno] from Student
order by [Updated Dno] asc

-- Join statement
Select * from Student S JOIN Dept D on S.dno = D.dno
order by S.dno asc

-- Left Outer Join
Select * from Student S Left Outer JOIN Dept D on S.dno = D.dno

-- Right Outer Join
Select * from Student S Right Outer JOIN Dept D on S.dno = D.dno

-- Full Join
Select * from Student S Full Outer JOIN Dept D on S.dno = D.dno

-- Nested Querries
Select rno, fname, lname, gender, age from Student s
where s.cgpa IN (Select max(cgpa) from Student)

Select rno, fname, lname, cgpa, dno, (Select avg(s.cgpa) AS [AVG_CGPA] from Student s) from Student

-- Maximum using top approach
Select top 1* from Student
where cgpa = (Select max(cgpa) from Student) 
order by cgpa desc

-- Right Outer Join
Select * from Student S Right Outer JOIN Dept D on S.dno = D.dno
where S.rno IS NULL

-- Intersection of the two tables on the basis of a common attribute
Select s.dno from Student s
INTERSECT
Select t.deptno from Teacher t

-- those departments not present in teacher table
Select dno from dept
except 
Select deptno from teacher

Select dno from Student
union 
Select dno from Dept

-- creation of view
Create view StudentSummary
AS
Select s.gender, count(s.gender) AS Total_Students, max(s.cgpa) AS Max_Cgpa, min(s.cgpa) AS Min_Cgpa, avg(s.cgpa) AS Avg_Cgpafrom Student s
group by s.genderhaving count(s.gender) > 1

-- calling a view
Select * from StudentSummary

-- Print number of teachers in the table
Select count(*) As [Count of Teachers] from Teacher

-- update statement format
update dept
set dno = 10
where dname = 'CS'

-- delete statement
delete from dept where dno = 10;

-- Algebric expression in Student table
Select s.rno, s.fname, s.lname, s.gender, s.dno, s.age, s.cgpa, (s.cgpa - 1.0) AS [New Cgpa]
from Student s
