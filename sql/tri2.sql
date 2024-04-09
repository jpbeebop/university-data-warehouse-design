CONNECT TO DB2;


--copy from operational database to data warehouse (Assessment_Mark->fact_Assessment_Mark)

--only semester 2

INSERT INTO Fact_Assessment_Mark(Student_ID, Course_Code, Assessment_Mark_Assignment, Assessment_Mark_Test, Assessment_Mark_Quiz, Assessment_Mark_Main_Exam, Assessment_Mark_Total, Assessment_Mark_Grade, Semester_ID, Lecturer_ID)
SELECT a.Student_ID, a.Course_Code, a.Assessment_Mark_Assignment, a.Assessment_Mark_Test, a.Assessment_Mark_Quiz, a.Assessment_Mark_Main_Exam, a.Assessment_Mark_Total, a.Assessment_Mark_Grade, s.Semester_ID, l.Lecturer_ID
FROM Assessment_Mark a, Course c, Semester s, Lecturer l
WHERE (a.Course_Code = c.Course_Code AND
	 c.Semester_ID = s.Semester_ID AND 
	 c.Lecturer_ID = l.Lecturer_ID AND 
	c.Semester_ID = 'SEM2');

SELECT * FROM Fact_Assessment_Mark;

CONNECT RESET;

TERMINATE;



