Create Database Eight_SQL_Project
Use Eight_SQL_Project

Create Table Employee_Data
(
Emp_ID Int Primary Key,
Emp_Name char (100),
Dept_ID int,
Salary int,
Joining_Date date,
Performance_Score int
)
Insert Into Employee_Data Values
(101,	'Amit',	1,	60000,	'2022-01-10',	85),
(102,	'Bhavna',	1,	55000,	'2022-06-15',	90),
(103,	'Chirag',	2,	72000,	'2021-09-01',	88),
(104,	'Deepa',	2,	69000,	'2023-02-20',	82),
(105,	'Eshan',	3,	50000,	'2022-11-05',	75),
(106,	'Farah',	3,	48000,	'2023-01-30',	78)

select * From Employee_Data

Create Table Department_Info
(
Dept_ID Int primary key,
Department_Name Varchar(50),
Manager_ID Int,
Budget Int
)

INSERT INTO Department_Info VALUES
(1, 'Sales', 101, 500000),
(2, 'Marketing', 103, 450000),
(3, 'Support', 105, 300000)

select * from Department_Info
---Emp_Name	Dept_ID	Performance_Score	RankInDept
---Bhavna   1		90					1
---Chirag   2		88					1
---Farah    3		78					1

---Filter employees earning above a threshold
Select Salary
from Employee_Data
where Salary > 60000
---Salary
---72000
---69000

---Find departments where the average performance score > 80
Select Dept_ID, Avg(Performance_Score) AS Avg_Performance
from Employee_Data
Group By Dept_ID
Having AVG(Performance_Score) > 80
---Dept_ID	Avg_Performance
---1		87
---2		85

---Rank employees based on performance within department
Select Dept_ID, Emp_Name, Performance_Score,
Rank() Over(Partition by Dept_ID Order by Performance_Score DESC) AS Performance_Rank
From Employee_Data
---Dept_ID	Emp_Name	Performance_Score	Performance_Rank
---1		Bhavna		90					1
---1		Amit		85					2
---2		Chirag      88					1
---2		Deepa       82					2
---3		Farah       78					1
---3		Eshan       75					2

---Join employee to their Manager_ID details 
Select E.*,
M.Emp_Name AS Manager_Name,
D.Department_Name
from Employee_Data E
Join
Department_Info D
On 
E.Dept_ID = D.Dept_ID
Join 
Employee_Data M
On
D.Manager_ID = M.Emp_ID
---Emp_ID	Emp_Name	Dept_ID	Salary	Joining_Date	Performance_Score	Manager_Name	Department_Name
---101		Amit        1		60000	2022-01-10		85					Amit            Sales
---102		Bhavna      1		55000	2022-06-15		90					Amit            Sales
---103		Chirag      2		72000	2021-09-01		88					Chirag          Marketing
---104		Deepa       2		69000	2023-02-20		82					Chirag          Marketing
---105		Eshan       3		50000	2022-11-05		75					Eshan           Support
---106		Farah       3		48000	2023-01-30		78					Eshan           Support

---Top 1 Performer Across the Company
Select TOP 1 *
From Employee_Data
Order By Performance_Score DESC
---Emp_ID	Emp_Name	Dept_ID	Salary	Joining_Date	Performance_Score
---102		Bhavna		1		55000	2022-06-15		90

---Top Performers by Department
SELECT * FROM 
(
SELECT 
Emp_Name, Dept_ID, Performance_Score,
RANK() OVER (PARTITION BY Dept_ID ORDER BY Performance_Score DESC) AS RankInDept
FROM Employee_Data
) Ranked
WHERE RankInDept = 1
---Emp_Name	Dept_ID	Performance_Score	RankInDept
---Bhavna   1		90					1
---Chirag   2		88					1
---Farah    3		78					1

---Top 3 Performers Overall
SELECT TOP 3 *
FROM Employee_Data
ORDER BY Performance_Score DESC
---Emp_ID	Emp_Name	Dept_ID	Salary	Joining_Date	Performance_Score
---102		Bhavna		1		55000	2022-06-15		90
---103		Chirag		2		72000	2021-09-01		88
---101		Amit		1		60000	2022-01-10		85