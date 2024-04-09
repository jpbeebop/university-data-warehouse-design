CONNECT TO DB2;

DROP TRIGGER Update_Grade;
DROP TRIGGER Update_Total_Mark;
DROP TABLE Student_Course;
DROP TABLE Academic_Post;
DROP TABLE Assessment_Mark;
DROP TABLE Course;
DROP TABLE Semester;
DROP TABLE Lecturer;
DROP TABLE Student;


--Student table
CREATE TABLE Student(
Student_ID CHAR(10) NOT NULL,
Student_Name VARCHAR(40) NOT NULL,
Student_Register_Date DATE,
Student_Age INT,
Student_Gender CHAR(1) CHECK(Student_Gender IN('F','M')),
Student_State_of_Origin VARCHAR(30),
Student_Highschool VARCHAR(40),
Student_SPM_UEC_Result VARCHAR(20),

CONSTRAINT Student_USE_PK PRIMARY KEY(Student_ID)
);


--Lecturer table
CREATE TABLE Lecturer(
Lecturer_ID CHAR(5) NOT NULL,
Lecturer_Name VARCHAR(40) NOT NULL,
Lecturer_Employment_Date DATE,
Lecturer_Age INT,
Lecturer_Highest_Qualification VARCHAR(90),
Lecturer_Major VARCHAR(50),

CONSTRAINT Lecturer_USE_PK PRIMARY KEY (Lecturer_ID)
);


--Semester table
CREATE TABLE Semester(
Semester_ID VARCHAR(4) NOT NULL,
Semester_Name VARCHAR(15) NOT NULL,

CONSTRAINT Semester_USE_PK PRIMARY KEY(Semester_ID) 
);


--Course table
CREATE TABLE Course(
Course_Code VARCHAR(7) NOT NULL,
Course_Name VARCHAR(50) NOT NULL,
Course_CreditHrs INT,
Semester_ID VARCHAR(4),
Lecturer_ID CHAR(5),

CONSTRAINT Course_USE_PK PRIMARY KEY(Course_Code),

CONSTRAINT Course_USE_FK_Semester FOREIGN KEY(Semester_ID) REFERENCES Semester(Semester_ID),

CONSTRAINT Course_USE_FK_Lecturer FOREIGN KEY(Lecturer_ID) REFERENCES Lecturer(Lecturer_ID)
);


--Assessment_Mark table
CREATE TABLE Assessment_Mark(
Student_ID CHAR(10) NOT NULL, 
Course_Code VARCHAR(7) NOT NULL,
Assessment_Mark_Assignment INT,
Assessment_Mark_Test INT,
Assessment_Mark_Quiz INT,
Assessment_Mark_Main_Exam INT,
Assessment_Mark_Total INT,
Assessment_Mark_Grade CHAR(1) CHECK(Assessment_Mark_Grade IN ('A','B','C','F')), 

CONSTRAINT Assessment_Mark_USE_PK 
PRIMARY KEY(Student_ID, Course_Code),

CONSTRAINT Assessment_Mark_USE_FK_Student 
FOREIGN KEY(Student_ID) REFERENCES Student(Student_ID),

CONSTRAINT Assessment_Mark_USE_FK_Course 
FOREIGN KEY(Course_Code) REFERENCES Course(Course_Code)
);


--Academic_Post table
CREATE TABLE Academic_Post(
Academic_Post_ID VARCHAR(7) NOT NULL, 
Academic_Post_Title VARCHAR(120) NOT NULL, 
Academic_Post_Type VARCHAR(20),
Lecturer_ID CHAR(5),

CONSTRAINT Academic_Post_USE_PK PRIMARY KEY(Academic_Post_ID),

CONSTRAINT Academic_Post_USE_FK_Lecturer
FOREIGN KEY(Lecturer_ID) REFERENCES Lecturer(Lecturer_ID) 
);


--Student_Course table
CREATE TABLE Student_Course(
Student_ID CHAR(10) NOT NULL,
Course_Code VARCHAR(7) NOT NULL, 

CONSTRAINT Student_Course_USE_PK PRIMARY KEY(Student_ID,Course_Code),

CONSTRAINT Student_Course_USE_FK_Student
FOREIGN KEY(Student_ID) REFERENCES Student(Student_ID), 

CONSTRAINT Student_Course_USE_FK_Course
FOREIGN KEY(Course_Code) REFERENCES Course(Course_Code) 
);


LIST TABLES;


--Update The sum of the mark per subject
CREATE TRIGGER Update_Total_Mark
NO CASCADE BEFORE INSERT ON Assessment_Mark
REFERENCING NEW as n
FOR EACH ROW
SET n.Assessment_Mark_Total = Assessment_Mark_Assignment + Assessment_Mark_Test + Assessment_Mark_Quiz + Assessment_Mark_Main_Exam;


--Update The grade of the mark per subject
CREATE TRIGGER Update_Grade
NO CASCADE BEFORE INSERT ON Assessment_Mark
REFERENCING NEW as n
FOR EACH ROW
SET n.Assessment_Mark_Grade = 
CASE
  WHEN(n.Assessment_Mark_Total >= 80 AND n.Assessment_Mark_Total <= 100) THEN 'A'
  WHEN(n.Assessment_Mark_Total >= 60 AND n.Assessment_Mark_Total < 80 ) THEN 'B'
  WHEN(n.Assessment_Mark_Total >= 50 AND n.Assessment_Mark_Total < 60 ) THEN 'C'
  ELSE 'F'
END;


--Insert value for Student

INSERT INTO Student
VALUES('1191101111',
	 'Tan Mei Ling',
	 '2022-04-01',
	 20,
	 'F',
	 'Johor',
	 'SMK Taman Puteri Wangsa',
	 '4A4B'
);

INSERT INTO Student
VALUES('1191101112',
	 'Darren Lee Chao Zheng',
	 '2022-04-01',
	 19,
	 'M',
	 'Johor',
	 'SMK Taman Pelangi Indah',
	 '2A6B1C'
);

INSERT INTO Student
VALUES('1191101113',
	 'Mohd Ali Bin Hussein',
	 '2022-04-01',
	 18,
	 'M',
	 'Melaka',
	 'SMK Agama Sultan Muhammad',
	 '7C'
);

INSERT INTO Student
VALUES('1191101114',
	 'Felicia Tan',
	 '2022-04-01',
	 18,
	 'F',
	 'Penang',
	 'Convent Light Street',
	 '10A'
);

INSERT INTO Student
VALUES('1191101115',
	 'Suveetha A/P Sukumaran',
	 '2022-04-01',
	 22,
	 'F',
	 'Perak',
	 'SMK Taman Molek',
	 '9A1B'
);

INSERT INTO Student
VALUES('1191301356',
	 'Theevashini A/P Rajan',
	 '2022-07-01',
	 22,
	 'F',
	 'Johor',
	 'SMK Taman Desa Tebrau',
	 '9B'
);

INSERT INTO Student
VALUES('1191101176',
	 'Teo Yong Ping',
	 '2022-07-01',
	 18,
	 'F',
	 'Johor',
	 'Chong Hwa High School',
	 '8A2B'
);

INSERT INTO Student
VALUES('1191101254',
	 'Siti Aminah Binti Suhaiman',
	 '2022-11-01',
	 22,
	 'F',
	 'Selangor',
	 'SMK Tinggi Klang',
	 '10A'
);

INSERT INTO Student
VALUES('1191101566',
	 'Mariah Sabrina Binti Ali',
	 '2022-11-01',
	 22,
	 'F',
	 'Selangor',
	 'SMK Tinggi Klang',
	 '9A1C'
);

INSERT INTO Student
VALUES('1191101590',
	 'Nur Rashmi Aizam binti Solekhan',
	 '2022-11-01',
	 20,
	 'F',
	 'Perak',
	 'SMK Taman Bukit Bintang',
	 '8C'
);

INSERT INTO Student
VALUES('1191101509',
	 'Mohammed W bin Yussof Awalluddin',
	 '2022-01-01',
	 22,
	 'M',
	 'Perak',
	 'SMK Taman Merah Kampar',
	 '8B'
);

INSERT INTO Student
VALUES('1191101287',
	 'Woo Ann Kei',
	 '2022-01-01',
	 18,
	 'F',
	 'Penang',
	 'Chung Ling Private High School',
	 '10B'
);

INSERT INTO Student
VALUES('1191301201',
	 'Muhamad Haji Nazrin Fairos',
	 '2022-01-01',
	 24,
	 'M',
	 'Perak',
	 'SMK Air Kuning',
	 '7A'
);

INSERT INTO Student
VALUES('1191101344',
	 'Krishen Puspanathan',
	 '2022-01-01',
	 20,
	 'M',
	 'Perak',
	 'SMK Alor Pongsu',
	 '5B3C'
);

INSERT INTO Student
VALUES('1191101231',
	 'Toh Koong Lan',
	 '2022-04-01',
	 22,
	 'F',
	 'Perak',
	 'SMK Alor Pongsu',
	 '6B2C'
);

INSERT INTO Student
VALUES('1191300345',
	 'Loo Yeu Po',
	 '2022-11-01',
	 18,
	 'F',
	 'Johor',
	 'Foon Yew High School',
	 '10A'
);

INSERT INTO Student
VALUES('1191209987',
	 'Tan Poh Kit',
	 '2022-01-01',
	 18,
	 'M',
	 'Johor',
	 'SMK Taman Desa Tebrau',
	 '6A3C'
);

INSERT INTO Student
VALUES('1191205334',
	 'Soh Xin Yi',
	 '2022-01-01',
	 20,
	 'F',
	 'Johor',
	 'SMK Taman Desa Tebrau',
	 '5A5B'
);

INSERT INTO Student
VALUES('1191101234',
	 'Adelaine Tan',
	 '2022-01-01',
	 20,
	 'F',
	 'Melaka',
	 'Pay Fong Middle School Malacca',
	 '10A'
);

INSERT INTO Student
VALUES('1191103578',
	 'Ng Yan Ting',
	 '2022-01-01',
	 20,
	 'F',
	 'Melaka',
	 'SMK Taman Tinggi Melaka',
	 '10A'
);

INSERT INTO Student
VALUES('1191306541',
	 'Muhammet Nik Rasid Halib',
	 '2022-01-01',
	 20,
	 'M',
	 'Melaka',
	 'Malacca High School',
	 '9A'
);

INSERT INTO Student
VALUES('1191203118',
	 'Gheetha A/L Rajagobal',
	 '2022-11-01',
	 19,
	 'M',
	 'Selangor',
	 'Kajang Highschool',
	 '6A2C'
);

INSERT INTO Student
VALUES('1191101432',
	 'Noor Nurfaatihah binti Muqriz',
	 '2022-01-01',
	 18,
	 'F',
	 'Kedah',
	 'SMK Air Merah',
	 '5A3C'
);

INSERT INTO Student
VALUES('1191103028',
	 'Kang Thoo Koy',
	 '2022-04-01',
	 19,
	 'F',
	 'Kedah',
	 'SMK Alor Janggus',
	 '6A2B'
);

INSERT INTO Student
VALUES('1191100548',
	 'Hooi Kiet Yatt',
	 '2022-01-01',
	 20,
	 'F',
	 'Melaka',
	 'Pay Fong Middle School Malacca',
	 '10A'
);

INSERT INTO Student
VALUES('1191103100',
	 'Nur Afiza binti Wan Enidzullah Najhi',
	 '2022-04-01',
	 18,
	 'F',
	 'Kedah',
	 'SMK Batu 5',
	 '8A'
);

INSERT INTO Student
VALUES('1191105122',
	 'Ravichandran Kumaresan A/L Moorthy',
	 '2022-01-01',
	 20,
	 'M',
	 'Perak',
	 'SMK Bata 2',
	 '7A3C'
);

INSERT INTO Student
VALUES('1191103577',
	 'Usman Muqriz bin Syed W Rasid',
	 '2022-04-01',
	 19,
	 'M',
	 'Perak',
	 'SMK Air Panas',
	 '2A5B1C'
);

INSERT INTO Student
VALUES('1191104118',
	 'Nor Shafiera Dzikri',
	 '2022-07-01',
	 20,
	 'F',
	 'Kelantan',
	 'SMK Abdul Samad',
	 '4A3B1C'
);

INSERT INTO Student
VALUES('1191102443',
	 'Siow Dim Whay',
	 '2022-07-01',
	 18,
	 'F',
	 'Kedah',
	 'SMK Bedong',
	 '3A5B'
);

select * from Student;


--Insert value for Lecturer
INSERT INTO Lecturer
VALUES('60590',
	 'Nadzirah binti Noorhakim',
	 '2017-02-28',
	 35,
	 'Bachelor''s Degree in Computer Science in Asia Pacific University',
	 'Data Analytics'
);

INSERT INTO Lecturer
VALUES('60594',
	 'Choong Jeng Key',
	 '2019-04-01',
	 30,
	 'Bachelor''s Degree in Software Engineering in Asia Pacific University',
	 'Software Engineering'
);

INSERT INTO Lecturer
VALUES('60591',
	 'Siva Kundargal A/L Devasagayam',
	 '2018-03-31',
	 45,
	 'Doctor of Philosophy in Computing in Universiti Sains Malaysia',
	 'Cyber Security'
);

INSERT INTO Lecturer
VALUES('60592',
	 'Kumar Marimuthu A/L Puspanathan',
	 '2017-05-09',
	 32,
	 'Bachelor''s Degree in Computer Science in Universiti Sains Malaysia',
	 'Intelligent Computing'
);

INSERT INTO Lecturer
VALUES('60593',
	 'Hj Che Firdaus bin Syed Jaman',
	 '2017-12-23',
	 40,
	 'Master''s Degree of Science in Aritificial Intelligence in Asia Pacific University',	 	 
	 'Aritificial Intelligence'
);

INSERT INTO Lecturer
VALUES('60595',
	 'Aaron Soon Peng Gek',
	 '2020-07-01',
	 37,
	 'Master''s Degree of Science in Cyber Security in Asia Pacific University',	 	 
	 'Cyber Security'
);

select * from Lecturer;


--Insert values for Semester table
INSERT INTO Semester
VALUES('SEM1',
 	  'Trimester 1');

INSERT INTO Semester
VALUES('SEM2',
 	  'Trimester 2');


INSERT INTO Semester
VALUES('SEM3',
 	  'Trimester 3');

select * from Semester;


--Insert values for Course tables
INSERT INTO Course
VALUES('TMA1101',
	 'Calculus',
	 4,
	 'SEM1',
	 '60593');

INSERT INTO Course
VALUES('TCP1101',
	 'Programming Fundamentals',
	 4,
	 'SEM1',
	 '60592');

INSERT INTO Course
VALUES('TMA1201',
	 'Discrete Structures & Probabilty',
	 4,
	 'SEM1',
	 '60595');

INSERT INTO Course
VALUES('TMA1301',
	 'Computational Methods',
	 4,
	 'SEM2',
	 '60593');

INSERT INTO Course
VALUES('TIS1101',
	 'Database Fundamental',
	 4,
	 'SEM2',
	 '60590');

INSERT INTO Course
VALUES('TSN1101',
	 'Computer Architecture & Organization',
	 4,
	 'SEM2',
	 '60594');

INSERT INTO Course
VALUES('TPT1201',
	 'Research Methodology in Computer Science',
	 4,
	 'SEM3',
	 '60591');

INSERT INTO Course
VALUES('TPT1101',
	 'Professional Development',
	 4,
	 'SEM3',
	 '60592');

INSERT INTO Course
VALUES('TCT1201',
	 'Object Oriented Programming & Data Structures',
	 4,
	 'SEM3',
	 '60594');

select * from Course;


--Insert values for Assessment_mark table 30 students 9 subjects, 270 values
INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TMA1101',
	 21,
	 16,
	 5,
 	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TCP1101',
	 20,
	 15,
 	 6,
 	 27,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TMA1201',
	 25,
	 18,
 	 8,
 	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TMA1301',
	 23,
 	 16,
 	 7,
 	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TIS1101',
	 26,
 	 15,
 	 6,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TSN1101',
 	 18,
 	 14,
 	 6,
 	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TPT1201',
	 25,
 	 17,
 	 8,
 	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TPT1101',
	 20,
 	 18,
 	 10,
 	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101111',
	 'TCT1201',
	 28,
 	 20,
 	 10,
 	 36,
	 NULL,
	 NULL
);

--student 2
INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TMA1101',
	 16,
 	 10,
 	 7,
 	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TCP1101',
	 20,
	 13,
 	 8, 
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TMA1201',
	 28,
	 20,
	 10,
	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TMA1301',
	 26,
	 18,
	 10,
 	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TIS1101',
	 20,
	 12,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TSN1101',
	 23,
	 16,
	 5,
 	 28,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TPT1201',
	 28,
	 20,
	 7,
	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TPT1101',
	 23,
	 16,
	 6,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101112',
	 'TCT1201',
	 25,
	 12,
	 8,
	 30,
	 NULL,
	 NULL
);

--student 3
INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TMA1101',
	 20,
	 13,
 	 8, 
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TCP1101',
	 16,
 	 10,
 	 7,
 	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TMA1201',
	 26,
	 18,
	 10,
 	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TMA1301',
	 28,
	 20,
	 10,
	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TIS1101',
	 23,
	 16,
	 5,
 	 28,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TSN1101',
	 20,
	 12,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TPT1201',
	 25,
	 12,
	 8,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TPT1101',
 	 28,
	 20,
	 7,
	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101113',
	 'TCT1201',
	 23,
	 16,
	 6,
	 33,
	 NULL,
	 NULL
);

--student 4
INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TMA1101',
	 24,
	 14,
 	 8, 
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TCP1101',
	 15,
 	 10,
 	 4,
 	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TMA1201',
	 24,
	 14,
	 10,
 	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TMA1301',
	 24,
	 20,
	 10,
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TIS1101',
	 24,
	 14,
	 5,
 	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TSN1101',
	 24,
	 12,
	 5,
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TPT1201',
	 24,
	 12,
	 6,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TPT1101',
 	 24,
	 13,
	 7,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101114',
	 'TCT1201',
	 23,
	 14,
	 6,
	 26,
	 NULL,
	 NULL
);


--student 5
INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TMA1101',
	 27,
	 17,
 	 8, 
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TCP1101',
	 25,
 	 20,
 	 9,
 	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TMA1201',
	 24,
	 15,
	 10,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TMA1301',
	 24,
	 20,
	 10,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TIS1101',
	 27,
	 17,
	 7,
 	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TSN1101',
	 26,
	 16,
	 9,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TPT1201',
	 27,
	 17,
	 9,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TPT1101',
 	 22,
	 16,
	 7,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101115',
	 'TCT1201',
	 23,
	 13,
	 6,
	 33,
	 NULL,
	 NULL
);

--student 6
INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TMA1101',
	 21,
	 14,
 	 8, 
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TCP1101',
	 25,
 	 20,
 	 9,
 	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TMA1201',
	 19,
	 12,
	 5,
 	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TMA1301',
	 24,
	 13,
	 6,
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TIS1101',
	 21,
	 14,
	 7,
 	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TSN1101',
	 20,
	 13,
	 5,
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TPT1201',
	 21,
	 12,
	 5,
	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TPT1101',
 	 20,
	 12,
	 6,
	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301356',
	 'TCT1201',
	 21,
	 10,
	 5,
	 23,
	 NULL,
	 NULL
);

--student 7
INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TMA1101',
	 25,
	 15,
 	 8, 
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TCP1101',
	 25,
 	 20,
 	 9,
 	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TMA1201',
	 24,
	 12,
	 5,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TMA1301',
	 22,
	 16,
	 7,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TIS1101',
	 27,
	 17,
	 7,
 	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TSN1101',
	 20,
	 16,
	 8,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TPT1201',
	 24,
	 14,
	 6,
	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TPT1101',
 	 24,
	 15,
	 5,
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101176',
	 'TCT1201',
	 21,
	 13,
	 5,
	 27,
	 NULL,
	 NULL
);

--student 8
INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TMA1101',
	 25,
	 19,
 	 8, 
	 39,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TCP1101',
	 28,
 	 20,
 	 9,
 	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TMA1201',
	 26,
	 16,
	 7,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TMA1301',
	 26,
	 16,
	 7,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TIS1101',
	 27,
	 17,
	 7,
 	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TSN1101',
	 25,
	 16,
	 8,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TPT1201',
	 27,
	 18,
	 6,
	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TPT1101',
 	 24,
	 18,
	 9,
	 39,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101254',
	 'TCT1201',
	 27,
	 17,
	 10,
	 37,
	 NULL,
	 NULL
);

--student 9
INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TMA1101',
	 25,
	 15,
 	 8, 
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TCP1101',
	 28,
 	 19,
 	 9,
 	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TMA1201',
	 24,
	 16,
	 7,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TMA1301',
	 25,
	 16,
	 8,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TIS1101',
	 27,
	 16,
	 10,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TSN1101',
	 24,
	 14,
	 8,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TPT1201',
	 25,
	 16,
	 6,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TPT1101',
 	 24,
	 15,
	 7,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101566',
	 'TCT1201',
	 25,
	 15,
	 6,
	 31,
	 NULL,
	 NULL
);

--student 10
INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TMA1101',
	 14,
	 9,
 	 5, 
	 15,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TCP1101',
	 18,
 	 14,
 	 5,
 	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TMA1201',
	 17,
	 11,
	 5,
 	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TMA1301',
	 10,
	 5,
	 5,
	 14,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TIS1101',
	 15,
	 10,
	 5,
 	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TSN1101',
	 20,
	 13,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TPT1201',
	 22,
	 16,
	 6,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TPT1101',
 	 24,
	 12,
	 5,
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101590',
	 'TCT1201',
	 25,
	 15,
	 5,
	 29,
	 NULL,
	 NULL
);

--student 11
INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TMA1101',
	 13,
	 3,
 	 3, 
	 12,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TCP1101',
	 15,
 	 16,
 	 6,
 	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TMA1201',
	 16,
	 16,
	 5,
 	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TMA1301',
	 19,
	 13,
	 6,
	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TIS1101',
	 15,
	 10,
	 5,
 	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TSN1101',
	 20,
	 15,
	 5,
	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TPT1201',
	 22,
	 15,
	 5,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TPT1101',
 	 24,
	 14,
	 8,
	 28,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101509',
	 'TCT1201',
	 20,
	 15,
	 5,
	 20,
	 NULL,
	 NULL
);

--student 12
INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TMA1101',
	 15,
	 15,
 	 5, 
	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TCP1101',
	 25,
 	 18,
 	 6,
 	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TMA1201',
	 26,
	 16,
	 5,
 	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TMA1301',
	 29,
	 19,
	 9,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TIS1101',
	 25,
	 15,
	 5,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TSN1101',
	 20,
	 16,
	 5,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TPT1201',
	 24,
	 15,
	 9,
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TPT1101',
 	 22,
	 14,
	 8,
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101287',
	 'TCT1201',
	 22,
	 15,
	 8,
	 28,
	 NULL,
	 NULL
);

--student 13
INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TMA1101',
	 20,
	 17,
 	 7, 
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TCP1101',
	 25,
 	 18,
 	 6,
 	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TMA1201',
	 26,
	 19,
	 9,
 	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TMA1301',
	 24,
	 19,
	 9,
	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TIS1101',
	 25,
	 16,
	 6,
 	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TSN1101',
	 22,
	 16,
	 5,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TPT1201',
	 27,
	 17,
	 9,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TPT1101',
 	 22,
	 14,
	 8,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191301201',
	 'TCT1201',
	 22,
	 15,
	 8,
	 30,
	 NULL,
	 NULL
);

--student 14
INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TMA1101',
	 20,
	 11,
 	 7, 
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TCP1101',
	 20,
 	 13,
 	 6,
 	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TMA1201',
	 21,
	 11,
	 5,
 	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TMA1301',
	 15,
	 10,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TIS1101',
	 25,
	 15,
	 5,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TSN1101',
	 22,
	 16,
	 7,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TPT1201',
	 23,
	 17,
	 5,
	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TPT1101',
 	 20,
	 10,
	 3,
	 13,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101344',
	 'TCT1201',
	 10,
	 10,
	 2,
	 15,
	 NULL,
	 NULL
);

--student 15
INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TMA1101',
	 20,
	 15,
 	 7, 
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TCP1101',
	 20,
 	 15,
 	 6,
 	 27,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TMA1201',
	 21,
	 15,
	 5,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TMA1301',
	 25,
	 19,
	 5,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TIS1101',
	 25,
	 15,
	 7,
 	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TSN1101',
	 22,
	 16,
	 6,
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TPT1201',
	 23,
	 14,
	 6,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TPT1101',
 	 20,
	 12,
	 5,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101231',
	 'TCT1201',
	 19,
	 12,
	 5,
	 20,
	 NULL,
	 NULL
);

--student 16
INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TMA1101',
	 26,
	 17,
 	 8, 
	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TCP1101',
	 28,
 	 20,
 	 9,
 	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TMA1201',
	 26,
	 16,
	 7,
 	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TMA1301',
	 26,
	 18,
	 8,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TIS1101',
	 27,
	 17,
	 7,
 	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TSN1101',
	 25,
	 16,
	 8,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TPT1201',
	 27,
	 17,
	 7,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TPT1101',
 	 25,
	 18,
	 9,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191300345',
	 'TCT1201',
	 27,
	 18,
	 10,
	 38,
	 NULL,
	 NULL
);

--student 17
INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TMA1101',
	 23,
	 13,
 	 5, 
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TCP1101',
	 22,
 	 16,
 	 9,
 	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TMA1201',
	 24,
	 16,
	 7,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TMA1301',
	 20,
	 15,
	 5,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TIS1101',
	 20,
	 15,
	 6,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TSN1101',
	 23,
	 16,
	 8,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TPT1201',
	 27,
	 17,
	 7,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TPT1101',
 	 25,
	 14,
	 5,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191209987',
	 'TCT1201',
	 24,
	 18,
	 10,
	 31,
	 NULL,
	 NULL
);

--student 18
INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TMA1101',
	 23,
	 13,
 	 5, 
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TCP1101',
	 22,
 	 16,
 	 9,
 	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TMA1201',
	 24,
	 16,
	 7,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TMA1301',
	 20,
	 15,
	 5,
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TIS1101',
	 20,
	 16,
	 6,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TSN1101',
	 23,
	 16,
	 8,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TPT1201',
	 27,
	 18,
	 9,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TPT1101',
 	 25,
	 16,
	 9,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191205334',
	 'TCT1201',
	 26,
	 18,
	 10,
	 37,
	 NULL,
	 NULL
);

--student 19
INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TMA1101',
	 23,
	 16,
 	 7, 
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TCP1101',
	 22,
 	 16,
 	 9,
 	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TMA1201',
	 24,
	 19,
	 7,
 	 39,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TMA1301',
	 27,
	 17,
	 7,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TIS1101',
	 20,
	 20,
	 10,
 	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TSN1101',
	 23,
	 19,
	 8,
	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TPT1201',
	 27,
	 18,
	 9,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TPT1101',
 	 25,
	 16,
	 8,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101234',
	 'TCT1201',
	 26,
	 18,
	 9,
	 35,
	 NULL,
	 NULL
);

--student 20
INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TMA1101',
	 25,
	 17,
 	 7, 
	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TCP1101',
	 22,
 	 17,
 	 9,
 	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TMA1201',
	 24,
	 18,
	 7,
 	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TMA1301',
	 27,
	 17,
	 7,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TIS1101',
	 26,
	 20,
	 10,
 	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TSN1101',
	 28,
	 19,
	 7,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TPT1201',
	 27,
	 18,
	 7,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TPT1101',
 	 23,
	 18,
	 8,
	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103578',
	 'TCT1201',
	 27,
	 18,
	 9,
	 38,
	 NULL,
	 NULL
);

--student 21
INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TMA1101',
	 20,
	 17,
 	 5, 
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TCP1101',
	 22,
 	 17,
 	 5,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TMA1201',
	 20,
	 18,
	 5,
 	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TMA1301',
	 22,
	 17,
	 6,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TIS1101',
	 26,
	 20,
	 10,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TSN1101',
	 22,
	 19,
	 5,
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TPT1201',
	 22,
	 18,
	 6,
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TPT1101',
 	 23,
	 18,
	 8,
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191306541',
	 'TCT1201',
	 27,
	 16,
	 9,
	 32,
	 NULL,
	 NULL
);

--student 22
INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TMA1101',
	 19,
	 13,
 	 3, 
	 19,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TCP1101',
	 20,
 	 15,
 	 6,
 	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TMA1201',
	 19,
	 12,
	 5,
 	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TMA1301',
	 18,
	 7,
	 3,
	 16,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TIS1101',
	 22,
	 17,
	 7,
 	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TSN1101',
	 22,
	 15,
	 5,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TPT1201',
	 22,
	 15,
	 8,
	 31,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TPT1101',
 	 23,
	 15,
	 8,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191203118',
	 'TCT1201',
	 23,
	 15,
	 5,
	 32,
	 NULL,
	 NULL
);

--student 23
INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TMA1101',
	 24,
	 17,
 	 5, 
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TCP1101',
	 25,
 	 15,
 	 6,
 	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TMA1201',
	 23,
	 16,
	 5,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TMA1301',
	 18,
	 17,
	 5,
	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TIS1101',
	 22,
	 15,
	 7,
 	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TSN1101',
	 22,
	 15,
	 5,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TPT1201',
	 25,
	 15,
	 8,
	 26,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TPT1101',
 	 23,
	 15,
	 6,
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191101432',
	 'TCT1201',
	 24,
	 15,
	 7,
	 26,
	 NULL,
	 NULL
);

--student 24
INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TMA1101',
	 20,
	 15,
 	 5, 
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TCP1101',
	 25,
 	 15,
 	 6,
 	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TMA1201',
	 23,
	 15,
	 5,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TMA1301',
	 26,
	 17,
	 5,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TIS1101',
	 22,
	 16,
	 7,
 	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TSN1101',
	 28,
	 18,
	 9,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TPT1201',
	 25,
	 17,
	 8,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TPT1101',
 	 23,
	 15,
	 6,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103028',
	 'TCT1201',
	 24,
	 15,
	 5,
	 26,
	 NULL,
	 NULL
);

--student 25
INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TMA1101',
	 29,
	 19,
 	 9, 
	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TCP1101',
	 25,
 	 15,
 	 9,
 	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TMA1201',
	 23,
	 15,
	 5,
 	 35,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TMA1301',
	 26,
	 17,
	 7,
	 38,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TIS1101',
	 27,
	 16,
	 7,
 	 37,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TSN1101',
	 28,
	 18,
	 8,
	 36,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TPT1201',
	 25,
	 17,
	 8,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TPT1101',
 	 23,
	 16,
	 6,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191100548',
	 'TCT1201',
	 24,
	 16,
	 6,
	 29,
	 NULL,
	 NULL
);

--student 26
INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TMA1101',
	 23,
	 15,
 	 9, 
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TCP1101',
	 25,
 	 15,
 	 8,
 	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TMA1201',
	 25,
	 15,
	 5,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TMA1301',
	 24,
	 17,
	 7,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TIS1101',
	 27,
	 16,
	 7,
 	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TSN1101',
	 24,
	 14,
	 8,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TPT1201',
	 25,
	 17,
	 6,
	 34,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TPT1101',
 	 23,
	 14,
	 6,
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103100',
	 'TCT1201',
	 25,
	 15,
	 6,
	 32,
	 NULL,
	 NULL
);


--student 27
INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TMA1101',
	 23,
	 15,
 	 8, 
	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TCP1101',
	 25,
 	 15,
 	 6,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TMA1201',
	 24,
	 15,
	 6,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TMA1301',
	 24,
	 15,
	 7,
	 33,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TIS1101',
	 25,
	 16,
	 7,
 	 30,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TSN1101',
	 22,
	 14,
	 7,
	 32,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TPT1201',
	 25,
	 15,
	 6,
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TPT1101',
 	 23,
	 14,
	 5,
	 29,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191105122',
	 'TCT1201',
	 25,
	 14,
	 6,
	 31,
	 NULL,
	 NULL
);

--student 28
INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TMA1101',
	 15,
	 10,
 	 8, 
	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TCP1101',
	 16,
 	 11,
 	 6,
 	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TMA1201',
	 14,
	 15,
	 6,
 	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TMA1301',
	 20,
	 15,
	 5,
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TIS1101',
	 20,
	 13,
	 5,
 	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TSN1101',
	 23,
	 15,
	 4,
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TPT1201',
	 22,
	 14,
	 5,
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TPT1101',
 	 23,
	 12,
	 5,
	 24,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191103577',
	 'TCT1201',
	 21,
	 13,
	 6,
	 23,
	 NULL,
	 NULL
);

--student 29
INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TMA1101',
	 20,
	 13,
 	 8, 
	 28,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TCP1101',
	 21,
 	 15,
 	 6,
 	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TMA1201',
	 21,
	 13,
	 6,
 	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TMA1301',
	 20,
	 15,
	 5,
	 25,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TIS1101',
	 20,
	 15,
	 5,
 	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TSN1101',
	 23,
	 15,
	 5,
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TPT1201',
	 22,
	 15,
	 5,
	 22,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TPT1101',
 	 21,
	 12,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191104118',
	 'TCT1201',
	 21,
	 13,
	 6,
	 21,
	 NULL,
	 NULL
);

--student 30
INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TMA1101',
	 15,
	 10,
 	 5, 
	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TCP1101',
	 20,
 	 12,
 	 5,
 	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TMA1201',
	 20,
	 13,
	 4,
 	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TMA1301',
	 20,
	 15,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TIS1101',
	 21,
	 12,
	 5,
 	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TSN1101',
	 23,
	 15,
	 5,
	 20,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TPT1201',
	 21,
	 15,
	 5,
	 21,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TPT1101',
 	 21,
	 10,
	 5,
	 23,
	 NULL,
	 NULL
);

INSERT INTO Assessment_mark
VALUES('1191102443',
	 'TCT1201',
	 22,
	 15,
	 6,
	 24,
	 NULL,
	 NULL
);

select * from Assessment_mark;


--Insert values for Academic_post table
INSERT INTO Academic_post 
VALUES('B001011',
	 'Execution Models for Mobile Data Analytics',
	 'Journal Article',
	 '60590');

INSERT INTO Academic_post 
VALUES('B001012',
	 'Bayesian Networks For Evidence-Based Decision-Making in Software Engineering',
	 'Journal Article',
	 '60594');

INSERT INTO Academic_post 
VALUES('B001013',
	 'Security Verification for Cyber-Physical Systems Using Model Checking',
	 'Journal Article',
	 '60591');

INSERT INTO Academic_post 
VALUES('B001014',
	 'Power System Security With Cyber-Physical Power System Operation',
	 'Journal Article',
	 '60591');

INSERT INTO Academic_post 
VALUES('B001015',
	 'Design of a Cosimulation Platform With Hardware-in-the-Loop for Cyber-Attacks on Cyber-Physical Power Systems',
	 'Journal Article',
	 '60591');

INSERT INTO Academic_post 
VALUES('B001016',
	 'Internet of Things Based Smart Grids Supported by Intelligent Edge Computing',
	 'Journal Article',
	 '60592');

INSERT INTO Academic_post 
VALUES('B001017',
	 'Intrusion Detection of Imbalanced Network Traffic Based on Machine Learning and Deep Learning',
	 'Journal Article',
	 '60593');

INSERT INTO Academic_post 
VALUES('B001018',
	 'Combining Supervised and Unsupervised Learning for Improved miRNA Target Prediction',
	 'Journal Article',
	 '60593');

INSERT INTO Academic_post 
VALUES('B001019',
	 'A Game-Theoretic Approach to Cross-Layer Security Decision-Making in Industrial Cyber-Physical Systems',
	 'Journal Article',
	 '60595');

INSERT INTO Academic_post 
VALUES('B001020',
	 'Offensive Security: Towards Proactive Threat Hunting via Adversary Emulation',
	 'Journal Article',
	 '60595');

select * from Academic_post;


--Insert values for Student_Course table

--student 1
INSERT INTO Student_Course 
VALUES('1191101111',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101111',
	 'TCT1201');

--student 2
INSERT INTO Student_Course 
VALUES('1191101112',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101112',
	 'TCT1201');

--student 3
INSERT INTO Student_Course 
VALUES('1191101113',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101113',
	 'TCT1201');

--student 4
INSERT INTO Student_Course 
VALUES('1191101114',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101114',
	 'TCT1201');

--student 5
INSERT INTO Student_Course 
VALUES('1191101115',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101115',
	 'TCT1201');

--student 6
INSERT INTO Student_Course 
VALUES('1191301356',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191301356',
	 'TCT1201');

--student 7
INSERT INTO Student_Course 
VALUES('1191101176',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101176',
	 'TCT1201');

--student 8
INSERT INTO Student_Course 
VALUES('1191101254',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101254',
	 'TCT1201');

--student 9
INSERT INTO Student_Course 
VALUES('1191101566',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101566',
	 'TCT1201');

--student 10
INSERT INTO Student_Course 
VALUES('1191101590',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101590',
	 'TCT1201');

--student 11
INSERT INTO Student_Course 
VALUES('1191101509',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101509',
	 'TCT1201');

--student 12
INSERT INTO Student_Course 
VALUES('1191101287',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101287',
	 'TCT1201');

--student 13
INSERT INTO Student_Course 
VALUES('1191301201',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191301201',
	 'TCT1201');

--student 14
INSERT INTO Student_Course 
VALUES('1191101344',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101344',
	 'TCT1201');

--student 15
INSERT INTO Student_Course 
VALUES('1191101231',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101231',
	 'TCT1201');

--student 16
INSERT INTO Student_Course 
VALUES('1191300345',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191300345',
	 'TCT1201');

--student 17
INSERT INTO Student_Course 
VALUES('1191209987',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191209987',
	 'TCT1201');

--student 18
INSERT INTO Student_Course 
VALUES('1191205334',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191205334',
	 'TCT1201');

--student 19
INSERT INTO Student_Course 
VALUES('1191101234',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101234',
	 'TCT1201');

--student 20
INSERT INTO Student_Course 
VALUES('1191103578',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191103578',
	 'TCT1201');

--student 21
INSERT INTO Student_Course 
VALUES('1191306541',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191306541',
	 'TCT1201');

--student 22
INSERT INTO Student_Course 
VALUES('1191203118',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191203118',
	 'TCT1201');

--student 23
INSERT INTO Student_Course 
VALUES('1191101432',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191101432',
	 'TCT1201');

--student 24
INSERT INTO Student_Course 
VALUES('1191103028',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191103028',
	 'TCT1201');

--student 25
INSERT INTO Student_Course 
VALUES('1191100548',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191100548',
	 'TCT1201');

--student 26
INSERT INTO Student_Course 
VALUES('1191103100',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191103100',
	 'TCT1201');

--student 27
INSERT INTO Student_Course 
VALUES('1191105122',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191105122',
	 'TCT1201');

--student 28
INSERT INTO Student_Course 
VALUES('1191103577',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191103577',
	 'TCT1201');

--student 29
INSERT INTO Student_Course 
VALUES('1191104118',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191104118',
	 'TCT1201');

--student 30
INSERT INTO Student_Course 
VALUES('1191102443',
	 'TMA1101');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TCP1101');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TMA1201');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TMA1301');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TIS1101');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TSN1101');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TPT1201');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TPT1101');

INSERT INTO Student_Course 
VALUES('1191102443',
	 'TCT1201');

select * from Student_Course;


CONNECT RESET;

TERMINATE;



