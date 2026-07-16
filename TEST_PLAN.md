\# Test Plan - University Record Management System



\*\*Tester:\*\* Chigumira  

\*\*Date:\*\* July 2026



\---



\## 1. Overview



This document outlines the testing strategy for the University Record Management System. All 5 queries will be tested against the PostgreSQL database.



\---



\## 2. Test Environment



| Component | Details |

|-----------|---------|

| Database | PostgreSQL 16 |

| Python | 3.11.9 |

| OS | Windows 10 |



\---



\## 3. Query Test Cases



\### Query 1: Students enrolled in CS101 by Dr. Turing



\*\*Method:\*\* `get\_students\_by\_course\_lecturer(course\_code, lecturer\_id)`



| Test Case | Input | Expected Output |

|-----------|-------|-----------------|

| TC-101 | course='CS101', lecturer='L001' | John Doe, Bob Johnson (2 students) |

| TC-102 | Valid course, invalid lecturer | Empty list \[] |

| TC-103 | Invalid course | Empty list \[] |



\---



\### Query 2: Final Year High Achievers (>70%)



\*\*Method:\*\* `get\_final\_year\_high\_achievers(min\_grade=70.0)`



| Test Case | Input | Expected Output |

|-----------|-------|-----------------|

| TC-201 | min\_grade=70.0 | Students with avg > 70% in year 4 |

| TC-202 | min\_grade=80.0 | Students with avg > 80% in year 4 |

| TC-203 | min\_grade=0.0 | All final year students |



\---



\### Query 3: Unregistered Students (Spring 2024)



\*\*Method:\*\* `get\_unregistered\_students(semester)`



| Test Case | Input | Expected Output |

|-----------|-------|-----------------|

| TC-301 | semester='Spring 2024' | Students with no enrollments |

| TC-302 | semester='Fall 2024' | Students with no enrollments for Fall |

| TC-303 | Invalid semester | Empty list \[] |



\---



\### Query 4: Advisor Contact for John Doe



\*\*Method:\*\* `get\_advisor\_contact(student\_id)`



| Test Case | Input | Expected Output |

|-----------|-------|-----------------|

| TC-401 | student\_id='S001' | Dr. Alan Turing's contact details |

| TC-402 | Invalid student ID | None |

| TC-403 | Student with no advisor | None |



\---



\### Query 5: Lecturers in 'Machine Learning'



\*\*Method:\*\* `get\_lecturers\_by\_research\_area(research\_area)`



| Test Case | Input | Expected Output |

|-----------|-------|-----------------|

| TC-501 | research\_area='Machine Learning' | Dr. Turing, Dr. Smith |

| TC-502 | research\_area='NonExistentArea' | Empty list \[] |

| TC-503 | research\_area='' (empty) | All lecturers |



\---



\## 4. Edge Cases



| Edge Case | Expected Behavior |

|-----------|-------------------|

| Empty database | All queries return empty lists |

| SQL injection attempts | Safely escaped |

| Very long input strings | Handled without crashing |

| Special characters | Properly escaped |

| Invalid IDs | Return None or empty list |



\---



\## 5. Expected Results



For detailed expected results with sample data, see `EXPECTED\_RESULTS.md`.



\---



\## 6. Test Execution



```bash

\# Run all tests

python run\_all\_tests.py



\# Save results

python run\_all\_tests.py > test\_results.txt 2>\&1

