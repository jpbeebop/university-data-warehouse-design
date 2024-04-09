CONNECT TO DB2;

--query1
--calculate the number of each grade
--one semester should be 30 students
SELECT Course_Code, Assessment_Mark_Grade, COUNT(Assessment_Mark_Grade) AS Number_Of_Grade
FROM Fact_Assessment_Mark 
GROUP BY Course_Code, Assessment_Mark_Grade
ORDER BY Course_Code, Assessment_Mark_Grade;

--export to csv 
EXPORT TO C:\Users\USER\OneDrive\Desktop\ad-dba-sql\query1.csv OF DEL MODIFIED BY NOCHARDEL 
SELECT Course_Code, Assessment_Mark_Grade, COUNT(Assessment_Mark_Grade) AS Number_Of_Grade
FROM Fact_Assessment_Mark 
GROUP BY ROLLUP(Course_Code, Assessment_Mark_Grade)
ORDER BY Course_Code, Assessment_Mark_Grade;


--query 2
--display the lecturer name whose student failed in their subject
SELECT l.Lecturer_Name, c.Course_Name, a.Course_Code, COUNT(Assessment_Mark_Grade) AS Number_Of_Students_Fail
FROM Fact_Assessment_Mark a, Dim_Lecturer l, Dim_Course c
WHERE (l.Lecturer_ID = a.Lecturer_ID AND
	 c.Course_Code = a.Course_Code AND
	 Assessment_Mark_Grade = 'F')
GROUP BY l.Lecturer_Name, c.Course_Name, a.Course_Code;

--export to csv 
EXPORT TO C:\Users\USER\OneDrive\Desktop\ad-dba-sql\query2.csv OF DEL MODIFIED BY NOCHARDEL 
SELECT l.Lecturer_Name, c.Course_Name, a.Course_Code, COUNT(Assessment_Mark_Grade) AS Number_Of_Students_Fail
FROM Fact_Assessment_Mark a, Dim_Lecturer l, Dim_Course c
WHERE (l.Lecturer_ID = a.Lecturer_ID AND
	 c.Course_Code = a.Course_Code AND
	 Assessment_Mark_Grade = 'F')
GROUP BY l.Lecturer_Name, c.Course_Name, a.Course_Code;


--query 3
--calculate the average mark
SELECT Semester_ID, Course_Code, ROUND(AVG(Assessment_Mark_Total),2) AS Average_Assessment_Mark
FROM Fact_Assessment_Mark 
GROUP BY Semester_ID, Course_Code;

--export to csv 
EXPORT TO C:\Users\USER\OneDrive\Desktop\ad-dba-sql\query3.csv OF DEL MODIFIED BY NOCHARDEL 
SELECT Semester_ID, Course_Code, ROUND(AVG(Assessment_Mark_Total),2) AS Average_Assessment_Mark
FROM Fact_Assessment_Mark 
GROUP BY Semester_ID, Course_Code;


--query 4
--display the min and mode mark
SELECT Semester_ID, Course_Code, MAX(Assessment_Mark_Total) AS Highest_Assessment_Mark, MIN(Assessment_Mark_Total) AS Lowest_Assessment_Mark
FROM Fact_Assessment_Mark 
GROUP BY Semester_ID, Course_Code;

--export to csv 
EXPORT TO C:\Users\USER\OneDrive\Desktop\ad-dba-sql\query4.csv OF DEL MODIFIED BY NOCHARDEL 
SELECT Semester_ID, Course_Code, MAX(Assessment_Mark_Total) AS Highest_Assessment_Mark, MIN(Assessment_Mark_Total) AS Lowest_Assessment_Mark
FROM Fact_Assessment_Mark 
GROUP BY Semester_ID, Course_Code;


--query 5
--Find the lecturer who has the highest number of students who got A
SELECT l.Lecturer_Name, COUNT(a.Assessment_Mark_Grade) as Number_Of_Student_Get_A
FROM Fact_Assessment_Mark a, Dim_Lecturer l
WHERE (l.Lecturer_ID = a.Lecturer_ID AND
	 Assessment_Mark_Grade = 'A')
GROUP BY l.Lecturer_Name
ORDER BY Lecturer_Name DESC LIMIT 1;

--export to csv 
EXPORT TO C:\Users\USER\OneDrive\Desktop\ad-dba-sql\query5.csv OF DEL MODIFIED BY NOCHARDEL 
SELECT l.Lecturer_Name, COUNT(a.Assessment_Mark_Grade) as Number_Of_Student_Get_A
FROM Fact_Assessment_Mark a, Dim_Lecturer l
WHERE (l.Lecturer_ID = a.Lecturer_ID AND
	 Assessment_Mark_Grade = 'A')
GROUP BY l.Lecturer_Name
ORDER BY Lecturer_Name DESC LIMIT 1;


CONNECT RESET;

TERMINATE;

