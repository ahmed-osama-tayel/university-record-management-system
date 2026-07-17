# Test Report: University Record Management System

**Tester:** Chigumira

**Module:** CSCK542 Databases, Group C

## Summary

The automated test suite runs without a live database by mocking the
data access layer (`app.db.run_query`). Static analysis is enforced with
flake8. The results below reflect the suite on the `main` branch.

| Metric | Result |
|---|---|
| Total tests | 44 |
| Passed | 44 |
| Failed | 0 |
| Pass rate | 100% |
| flake8 | Clean |

## Test breakdown by file

| Test file | Tests | Focus |
|---|---|---|
| `tests/test_db.py` | 4 | Configuration loading and cursor handling |
| `tests/test_queries.py` | 18 | Each query calls `run_query` with the correct SQL and parameters |
| `tests/test_edge_cases.py` | 5 | Empty input, injection-as-parameter, and empty-result behaviour |
| `tests/test_main.py` | 16 | CLI menu, input validation, and dispatch |
| `tests/test_smoke.py` | 1 | Application imports and the query menu builds |

## Query coverage

All nine query functions in `app/queries.py` are covered by unit tests
that assert the SQL text and bound parameters. The expected output shape
for each query is defined in `EXPECTED_RESULTS.md`.

1. Students enrolled in a course taught by a lecturer
2. Lecturers with expertise in a research area
3. Final-year students with an average grade above 70%
4. Students not registered for any course this semester
5. Lecturer who has supervised the most student research projects
6. Contact details for a student's advisor
7. Courses taught by lecturers in a department
8. Staff working in a department
9. Lecturers who supervise research students in a program

## Security and quality checks

- All queries are parameterised, so user input is bound rather than
  concatenated into the SQL. `test_edge_cases.py` verifies that a
  malicious string is passed as a parameter and never appears in the SQL
  text.
- flake8 reports no issues across the codebase (configuration in
  `setup.cfg`).

## Outstanding

End-to-end verification against live data (loading `db/college_backup.sql`
into MySQL and confirming each query returns the correct rows) is tracked
separately as the live smoke test. The unit suite above does not exercise
a real database connection.

## Sign off

| Role | Name | Status |
|---|---|---|
| Tester | Chigumira | Automated suite passing |
