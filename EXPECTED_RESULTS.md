# Expected Results for University Record Management System Queries

## 1. Overview

This document defines what each query in the application should return
when executed correctly. It is used to validate query output during
testing. Function names refer to the callables in `app/queries.py`, and
the columns listed are the aliases returned by each query.

## 2. Queries

### Query 1: Students enrolled in a course taught by a lecturer
- Function: `students_in_course_by_lecturer(course_code, lecturer_last_name)`
- Parameters: a course code and a lecturer surname (matched case-insensitively).
- Returns columns: Student ID, Name, Program, Year.
- Expected: one row per student enrolled in that course in a semester where it was taught by the named lecturer; an empty result if there is no match.

### Query 2: Lecturers with expertise in a research area
- Function: `lecturers_by_expertise(research_area)`
- Parameters: a research area (substring match).
- Returns columns: Lecturer ID, Name, Department, Expertise Area.
- Expected: one row per matching expertise entry; an empty result if none match.

### Query 3: Final-year students with an average grade above 70%
- Function: `students_final_year_high_average()`
- Parameters: none.
- Returns columns: Student ID, Name, Program, Year, Average Grade.
- Expected: enrolled students in their final year whose mean grade exceeds 70, ordered by average grade descending.

### Query 4: Students not registered for any course this semester
- Function: `students_not_registered_this_semester(semester)`
- Parameters: a semester identifier (for example 2026-S1).
- Returns columns: Student ID, Name, Program, Year.
- Expected: enrolled students with no enrolment row for the given semester.

### Query 5: Lecturer who has supervised the most student research projects
- Function: `lecturer_most_student_projects()`
- Parameters: none.
- Returns columns: Lecturer ID, Name, Student Projects Supervised.
- Expected: lecturers ranked by the number of student research projects they supervise, most first.

### Query 6: Contact details for a student's advisor
- Function: `student_advisor_contact(student_name)`
- Parameters: a student name (substring match).
- Returns columns: Student ID, Student, Advisor, Advisor Email, Advisor Department.
- Expected: the advising lecturer's contact details for each matching student.

### Query 7: Courses taught by lecturers in a department
- Function: `courses_taught_in_department(dept_name)`
- Parameters: a department name.
- Returns columns: Lecturer, Course Code, Course, Semester.
- Expected: the courses delivered by lecturers in that department.

### Query 8: Staff working in a department
- Function: `staff_in_department(dept_name)`
- Parameters: a department name.
- Returns columns: Name, Role, Department.
- Expected: all personnel in that department, combining lecturers and non-academic staff through a UNION.

### Query 9: Lecturers who supervise research students in a program
- Function: `research_supervisors_in_program(program_name)`
- Parameters: a program name.
- Returns columns: Supervisor, Email, Program.
- Expected: the distinct lecturers supervising research students enrolled on that program.

## 3. General expectations

- Every query returns a `(columns, rows)` tuple. A query with no matching data returns an empty `rows` list, not an error.
- All parameters are bound as query parameters, so hostile input cannot alter the SQL.
