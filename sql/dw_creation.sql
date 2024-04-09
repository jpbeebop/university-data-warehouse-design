CONNECT TO DB2;

DROP TABLE Fact_Assessment_Mark;
DROP TABLE Dim_Academic_Post;
DROP TABLE Dim_Course;
DROP TABLE Dim_Semester;
DROP TABLE Dim_Lecturer;
DROP TABLE Dim_Student;


--Dim_Student table
CREATE TABLE Dim_Student(
Student_ID CHAR(10) NOT NULL,
Student_Name VARCHAR(40) NOT NULL,
Student_Register_Date DATE,
Student_Age INT,
Student_Gender CHAR(1) CHECK(Student_Gender IN('F','M')),
Student_State_of_Origin VARCHAR(30),
Student_Highschool VARCHAR(40),
Student_SPM_UEC_Result VARCHAR(20),

CONSTRAINT Dim_Student_USE_PK PRIMARY KEY(Student_ID)
);


--Dim_Lecturer table
CREATE TABLE Dim_Lecturer(
Lecturer_ID CHAR(5) NOT NULL,
Lecturer_Name VARCHAR(40) NOT NULL,
Lecturer_Employment_Date DATE,
Lecturer_Age INT,
Lecturer_Highest_Qualification VARCHAR(90),
Lecturer_Major VARCHAR(50),

CONSTRAINT Dim_Lecturer_USE_PK PRIMARY KEY (Lecturer_ID)
);


--Dim_Semester table
CREATE TABLE Dim_Semester(
Semester_ID VARCHAR(4) NOT NULL,
Semester_Name VARCHAR(15) NOT NULL,

CONSTRAINT Dim_Semester_USE_PK PRIMARY KEY(Semester_ID) 
);


--Dim_Course table
CREATE TABLE Dim_Course(
Course_Code VARCHAR(7) NOT NULL,
Course_Name VARCHAR(50) NOT NULL,
Course_CreditHrs INT,

CONSTRAINT Dim_Course_USE_PK PRIMARY KEY(Course_Code)
);


--Dim_Academic_Post table
CREATE TABLE Dim_Academic_Post(
Academic_Post_ID VARCHAR(7) NOT NULL, 
Academic_Post_Title VARCHAR(120) NOT NULL, 
Academic_Post_Type VARCHAR(20),
Lecturer_ID CHAR(5),

CONSTRAINT Dim_Academic_Post_USE_PK PRIMARY KEY(Academic_Post_ID),

CONSTRAINT Dim_Academic_Post_USE_FK_Lecturer
FOREIGN KEY(Lecturer_ID) REFERENCES Dim_Lecturer(Lecturer_ID) 
);


--Assessment_Mark table
CREATE TABLE Fact_Assessment_Mark(
Student_ID CHAR(10) NOT NULL, 
Course_Code VARCHAR(7) NOT NULL,
Lecturer_ID CHAR(5) NOT NULL, 
Semester_ID VARCHAR(4) NOT NULL,
Assessment_Mark_Assignment INT,
Assessment_Mark_Test INT,
Assessment_Mark_Quiz INT,
Assessment_Mark_Main_Exam INT,
Assessment_Mark_Total INT,
Assessment_Mark_Grade CHAR(1) CHECK(Assessment_Mark_Grade IN ('A','B','C','F')), 

CONSTRAINT Fact_Assessment_Mark_USE_PK 
PRIMARY KEY(Student_ID, Course_Code, Lecturer_ID, Semester_ID),

CONSTRAINT Fact_Assessment_Mark_USE_FK_Student 
FOREIGN KEY(Student_ID) REFERENCES Dim_Student(Student_ID),

CONSTRAINT Fact_Assessment_Mark_USE_FK_Course 
FOREIGN KEY(Course_Code) REFERENCES Dim_Course(Course_Code),

CONSTRAINT Fact_Assessment_Mark_USE_FK_Lecturer 
FOREIGN KEY(Lecturer_ID) REFERENCES Dim_Lecturer(Lecturer_ID),

CONSTRAINT Fact_Assessment_Mark_USE_FK_Semester
FOREIGN KEY(Semester_ID) REFERENCES Dim_Semester(Semester_ID)
);


LIST TABLES;

--copy from operational database to data warehouse (student->dim_student)
INSERT INTO Dim_Student
SELECT * FROM Student;

SELECT * FROM Dim_Student;


--copy from operational database to data warehouse (lecturer->dim_lecturer)
INSERT INTO Dim_Lecturer
SELECT * FROM Lecturer;

SELECT * FROM Dim_Lecturer;


--copy from operational database to data warehouse (semester->dim_semester)
INSERT INTO Dim_Semester
SELECT * FROM Semester;

SELECT * FROM Dim_Semester;


--copy from operational database to data warehouse (course->dim_course)
INSERT INTO Dim_Course (Course_Code, Course_Name,Course_CreditHrs)
SELECT Course_Code, Course_Name,Course_CreditHrs FROM Course;

SELECT * FROM Dim_Course;


--copy from operational database to data warehouse (academic_post->dim_academic_post)
INSERT INTO Dim_Academic_Post 
SELECT * FROM Academic_Post ;

SELECT * FROM Dim_Academic_Post;


CONNECT RESET;

TERMINATE;



