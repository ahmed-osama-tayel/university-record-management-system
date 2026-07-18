-- Screenshot queries for CSCK542 testing evidence.
-- Runs against university_db; each returns real rows.

USE university_db;

-- Q1: Students in a course taught by a lecturer
SELECT
    s.student_id AS `Student ID`,
    s.name AS `Name`,
    p.program_name AS `Program`,
    s.year_of_study AS `Year`
FROM students AS s
JOIN enrolments AS e ON e.student_id = s.student_id
JOIN teaching_assignments AS ta
    ON ta.course_code = e.course_code
    AND ta.semester = e.semester
JOIN lecturers AS l ON l.lecturer_id = ta.lecturer_id
JOIN programs AS p ON p.program_id = s.program_id
WHERE e.course_code = 'CS101'
  AND LOWER(l.name) LIKE LOWER('%Farouk%')
GROUP BY s.student_id, s.name, p.program_name, s.year_of_study
ORDER BY s.student_id;

-- Q2: Lecturers with expertise in a research area
SELECT
    l.lecturer_id AS `Lecturer ID`,
    l.name AS `Name`,
    d.dept_name AS `Department`,
    le.expertise_area AS `Expertise Area`
FROM lecturers AS l
JOIN lecturer_expertise AS le ON le.lecturer_id = l.lecturer_id
JOIN departments AS d ON d.dept_id = l.dept_id
WHERE LOWER(le.expertise_area) LIKE LOWER('%Data Mining%')
ORDER BY l.lecturer_id, le.expertise_area;

-- Q3: Final-year students with average > 70 percent
SELECT
    s.student_id            AS `Student ID`,
    s.name                  AS `Name`,
    p.program_name          AS `Program`,
    s.year_of_study         AS `Year`,
    ROUND(AVG(e.grade), 2)  AS `Average Grade`
FROM students AS s
JOIN programs AS p ON p.program_id = s.program_id
JOIN enrolments AS e ON e.student_id = s.student_id
WHERE s.graduation_status = 'Enrolled'
  AND s.year_of_study = p.duration_years
  AND e.grade IS NOT NULL
GROUP BY s.student_id, s.name, p.program_name, s.year_of_study
HAVING AVG(e.grade) > 70
ORDER BY `Average Grade` DESC, s.student_id;

-- Q4: Students not registered this semester
SELECT
    s.student_id     AS `Student ID`,
    s.name           AS `Name`,
    p.program_name   AS `Program`,
    s.year_of_study  AS `Year`
FROM students AS s
JOIN programs AS p ON p.program_id = s.program_id
WHERE s.graduation_status = 'Enrolled'
  AND NOT EXISTS (
      SELECT 1
      FROM enrolments AS e
      WHERE e.student_id = s.student_id
        AND e.semester = '2025-S2'
  )
ORDER BY s.student_id;

-- Q5: Lecturer supervising the most student projects
SELECT
    l.lecturer_id AS `Lecturer ID`,
    l.name        AS `Name`,
    COUNT(DISTINCT sup.project_id) AS `Student Projects Supervised`
FROM lecturers AS l
JOIN (
    SELECT pi_lecturer_id AS lecturer_id, project_id
    FROM research_projects
    UNION
    SELECT lecturer_id, project_id
    FROM project_lecturers
) AS sup ON sup.lecturer_id = l.lecturer_id
JOIN project_students AS ps ON ps.project_id = sup.project_id
GROUP BY l.lecturer_id, l.name
ORDER BY `Student Projects Supervised` DESC, l.name;

-- Q6: A student's advisor contact
SELECT
    s.student_id  AS `Student ID`,
    s.name        AS `Student`,
    l.name        AS `Advisor`,
    l.email       AS `Advisor Email`,
    d.dept_name   AS `Advisor Department`
FROM students AS s
JOIN lecturers AS l ON l.lecturer_id = s.advisor_id
JOIN departments AS d ON d.dept_id = l.dept_id
WHERE LOWER(s.name) LIKE LOWER('%Amira%')
ORDER BY s.student_id;

-- Q7: Courses taught by lecturers in a department
SELECT DISTINCT
    l.name        AS `Lecturer`,
    c.course_code AS `Course Code`,
    c.course_name AS `Course`,
    ta.semester   AS `Semester`
FROM departments AS d
JOIN lecturers AS l ON l.dept_id = d.dept_id
JOIN teaching_assignments AS ta ON ta.lecturer_id = l.lecturer_id
JOIN courses AS c ON c.course_code = ta.course_code
WHERE LOWER(d.dept_name) = LOWER('Computer Science')
ORDER BY l.name, ta.semester, c.course_code;

-- Q8: Staff in a department (UNION of lecturers + non-academic)
SELECT
    l.name       AS `Name`,
    'Lecturer'   AS `Role`,
    d.dept_name  AS `Department`
FROM lecturers AS l
JOIN departments AS d ON d.dept_id = l.dept_id
WHERE LOWER(d.dept_name) = LOWER('Computer Science')
UNION ALL
SELECT
    ns.name       AS `Name`,
    ns.job_title  AS `Role`,
    d.dept_name   AS `Department`
FROM non_academic_staff AS ns
JOIN departments AS d ON d.dept_id = ns.dept_id
WHERE LOWER(d.dept_name) = LOWER('Computer Science')
ORDER BY `Role`, `Name`;

-- Q9: Research supervisors in a program
SELECT DISTINCT
    l.name         AS `Supervisor`,
    l.email        AS `Email`,
    p.program_name AS `Program`
FROM (
    SELECT pi_lecturer_id AS lecturer_id, project_id
    FROM research_projects
    UNION
    SELECT lecturer_id, project_id
    FROM project_lecturers
) AS sup
JOIN project_students AS ps ON ps.project_id = sup.project_id
JOIN students AS s ON s.student_id = ps.student_id
JOIN programs AS p ON p.program_id = s.program_id
JOIN lecturers AS l ON l.lecturer_id = sup.lecturer_id
WHERE LOWER(p.program_name) = LOWER('Computer Science')
ORDER BY l.name;
