"""Edge case tests for the query layer.

These tests mock ``app.db.run_query`` so they run without a live
database, mirroring the approach in ``tests/test_queries.py``. They
check that the query functions pass their inputs through safely as
parameters (so hostile input cannot alter the SQL) and return whatever
``run_query`` yields, including the empty result set.
"""
from unittest import mock

from app import queries


@mock.patch("app.db.run_query")
def test_empty_string_inputs_are_passed_through(run_query):
    run_query.return_value = (["Student ID"], [])

    columns, rows = queries.students_in_course_by_lecturer("", "")

    run_query.assert_called_once_with(
        queries.STUDENTS_IN_COURSE_BY_LECTURER, ("", "%%"),
    )
    assert rows == []


@mock.patch("app.db.run_query")
def test_malicious_input_is_parameterised_not_interpolated(run_query):
    run_query.return_value = (["Student ID"], [])
    malicious = "'; DROP TABLE students; --"

    queries.students_in_course_by_lecturer(malicious, "Smith")

    called_sql, called_params = run_query.call_args[0]
    # the payload travels as a bound parameter, never inside the SQL text
    assert malicious not in called_sql
    assert called_params[0] == malicious


@mock.patch("app.db.run_query")
def test_unknown_course_returns_empty_result(run_query):
    run_query.return_value = (["Student ID"], [])

    columns, rows = queries.students_in_course_by_lecturer(
        "NONEXISTENT", "Nobody",
    )

    assert rows == []


@mock.patch("app.db.run_query")
def test_empty_research_area_wildcards_to_match_all(run_query):
    run_query.return_value = (["Lecturer ID"], [])

    queries.lecturers_by_expertise("")

    run_query.assert_called_once_with(
        queries.LECTURERS_BY_EXPERTISE, ("%%",),
    )


@mock.patch("app.db.run_query")
def test_unknown_student_advisor_returns_empty(run_query):
    run_query.return_value = (["Student"], [])

    columns, rows = queries.student_advisor_contact("No Such Person")

    assert rows == []
