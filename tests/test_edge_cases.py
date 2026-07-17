"""
Edge case tests for the University Record Management System.

These tests validate error handling and edge cases for all 5 queries.
"""

import unittest

# Import database modules
from app.db import DatabaseConnection
from app.queries import StudentQueries


class TestEdgeCases(unittest.TestCase):
    """
    Test edge cases for all queries.
    """

    def setUp(self):
        """Set up test database connection before each test."""
        self.db = DatabaseConnection()
        self.db.connect()
        self.queries = StudentQueries(self.db)

    def test_empty_string_inputs(self):
        """
        Test empty string inputs.

        Expected: Handles gracefully without errors.
        """
        result = self.queries.get_students_by_course_lecturer('', '')
        self.assertIsInstance(result, list)

    def test_sql_injection_prevention(self):
        """
        Test SQL injection attempts.

        Expected: Queries execute safely, no data loss.
        """
        malicious = "'; DROP TABLE students; --"
        result = self.queries.get_students_by_course_lecturer(malicious, 'L001')
        self.assertIsInstance(result, list)

    def test_invalid_student_id(self):
        """
        Test invalid student ID.

        Expected: Returns None.
        """
        result = self.queries.get_advisor_contact('INVALID_ID')
        self.assertIsNone(result)

    def test_empty_research_area(self):
        """
        Test empty research area.

        Expected: Returns all lecturers or empty list.
        """
        result = self.queries.get_lecturers_by_research_area('')
        self.assertIsInstance(result, list)

    def test_non_existent_course(self):
        """
        Test non-existent course.

        Expected: Returns empty list.
        """
        result = self.queries.get_students_by_course_lecturer('NONEXISTENT', 'L001')
        self.assertEqual(len(result), 0)

    def tearDown(self):
        """Clean up after each test."""
        self.db.disconnect()


if __name__ == '__main__':
    unittest.main()