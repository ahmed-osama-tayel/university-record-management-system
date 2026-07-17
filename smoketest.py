"""End-to-end smoke test against a live MySQL database (CSC-36).

Loads db/college_backup.sql into the configured database, then runs
every query in app.queries against the real data and prints a compact
result summary. Exits non-zero if any query errors.

Usage:
    1. copy .env.example to .env and set DB_PASSWORD
    2. python smoketest.py
"""
import os
import sys

import mysql.connector
from dotenv import load_dotenv

from app import queries

load_dotenv()

CFG = {
    "host": os.environ.get("DB_HOST", "127.0.0.1"),
    "port": int(os.environ.get("DB_PORT", "3306")),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", ""),
}
DB_NAME = os.environ.get("DB_NAME", "university_db")

# (function, kwargs) using values known to exist in the seed data
CASES = [
    ("students_in_course_by_lecturer", {"course_code": "CS101",
                                        "lecturer_last_name": ""}),
    ("lecturers_by_expertise", {"research_area": ""}),
    ("students_final_year_high_average", {}),
    ("students_not_registered_this_semester", {"semester": "2026-S1"}),
    ("lecturer_most_student_projects", {}),
    ("student_advisor_contact", {"student_name": ""}),
    ("courses_taught_in_department", {"dept_name": "Computer Science"}),
    ("staff_in_department", {"dept_name": "Computer Science"}),
    ("research_supervisors_in_program", {"program_name": "Computer Science"}),
]


def split_statements(sql):
    """Split a SQL script into statements, ignoring semicolons that fall
    inside quoted strings or line comments."""
    statements, buf = [], []
    in_str = None
    escaped = False
    for line in sql.splitlines():
        stripped = line.strip()
        if stripped.startswith("--") or stripped.startswith("/*"):
            continue
        for ch in line:
            if in_str:
                if escaped:
                    escaped = False
                elif ch == "\\":
                    escaped = True
                elif ch == in_str:
                    in_str = None
                buf.append(ch)
            else:
                if ch in ("'", '"', "`"):
                    in_str = ch
                    buf.append(ch)
                elif ch == ";":
                    stmt = "".join(buf).strip()
                    if stmt:
                        statements.append(stmt)
                    buf = []
                else:
                    buf.append(ch)
        buf.append("\n")
    tail = "".join(buf).strip()
    if tail:
        statements.append(tail)
    return statements


def load_dump():
    conn = mysql.connector.connect(**CFG)
    cur = conn.cursor()
    cur.execute("CREATE DATABASE IF NOT EXISTS `%s`" % DB_NAME)
    cur.execute("USE `%s`" % DB_NAME)
    with open("db/college_backup.sql", encoding="utf-8") as fh:
        sql = fh.read()
    # the dump orders tables before their FK targets, so relax FK checks
    # during the load and restore them afterwards
    cur.execute("SET FOREIGN_KEY_CHECKS = 0")
    count = 0
    for stmt in split_statements(sql):
        cur.execute(stmt)
        count += 1
    cur.execute("SET FOREIGN_KEY_CHECKS = 1")
    conn.commit()
    cur.close()
    conn.close()
    print("Loaded db/college_backup.sql into `%s` (%d statements)"
          % (DB_NAME, count))


def run():
    failures = 0
    for name, kwargs in CASES:
        try:
            columns, rows = getattr(queries, name)(**kwargs)
            sample = rows[0] if rows else "(no rows)"
            print("PASS  %-38s %3d rows  %s" % (name, len(rows), sample))
        except Exception as exc:  # noqa: BLE001
            failures += 1
            print("FAIL  %-38s %s" % (name, exc))
    return failures


if __name__ == "__main__":
    load_dump()
    print("-" * 70)
    failures = run()
    print("-" * 70)
    print("%d/%d queries ran cleanly" % (len(CASES) - failures, len(CASES)))
    sys.exit(1 if failures else 0)
