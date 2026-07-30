#!/bin/bash

HOST=127.0.0.1
USER=root
PASS=root

echo "===================================="
echo "   SQL Assignment Autograder"
echo "===================================="

# Execute student's SQL file
echo "Running starter.sql..."
mysql -h$HOST -u$USER -p$PASS < starter.sql

TOTAL=0

echo ""
echo "Running Tests..."
echo "-----------------------------"

# Test 1: Database exists
DB=$(mysql -h$HOST -u$USER -p$PASS -Nse "SHOW DATABASES LIKE 'CollegeDB';")

if [ "$DB" = "CollegeDB" ]; then
    echo "✅ Test 1 Passed: CollegeDB exists"
    TOTAL=$((TOTAL+2))
else
    echo "❌ Test 1 Failed: CollegeDB not found"
    exit 1
fi

# Test 2: Department table exists
TABLE=$(mysql -h$HOST -u$USER -p$PASS -Nse "USE CollegeDB; SHOW TABLES LIKE 'Department';")

if [ "$TABLE" = "Department" ]; then
    echo "✅ Test 2 Passed: Department table exists"
    TOTAL=$((TOTAL+2))
else
    echo "❌ Test 2 Failed: Department table not found"
    exit 1
fi

# Test 3: DepartmentID column exists
COL=$(mysql -h$HOST -u$USER -p$PASS -Nse "
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Department'
AND COLUMN_NAME='DepartmentID';
")

if [ "$COL" = "DepartmentID" ]; then
    echo "✅ Test 3 Passed: DepartmentID exists"
    TOTAL=$((TOTAL+2))
else
    echo "❌ Test 3 Failed"
fi

# Test 4: Primary Key
PK=$(mysql -h$HOST -u$USER -p$PASS -Nse "
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Department'
AND CONSTRAINT_NAME='PRIMARY';
")

if [ "$PK" = "DepartmentID" ]; then
    echo "✅ Test 4 Passed: Primary Key correct"
    TOTAL=$((TOTAL+2))
else
    echo "❌ Test 4 Failed"
fi

# Test 5: DepartmentName datatype
TYPE=$(mysql -h$HOST -u$USER -p$PASS -Nse "
SELECT COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Department'
AND COLUMN_NAME='DepartmentName';
")

if [ "$TYPE" = "varchar(20)" ]; then
    echo "✅ Test 5 Passed: DepartmentName datatype correct"
    TOTAL=$((TOTAL+1))
else
    echo "❌ Test 5 Failed"
fi

# Test 6: HOD datatype
TYPE=$(mysql -h$HOST -u$USER -p$PASS -Nse "
SELECT COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Department'
AND COLUMN_NAME='HOD';
")

if [ "$TYPE" = "varchar(20)" ]; then
    echo "✅ Test 6 Passed: HOD datatype correct"
    TOTAL=$((TOTAL+1))
else
    echo "❌ Test 6 Failed"
fi

echo ""
echo "===================================="
echo "Final Score : $TOTAL / 10"
echo "===================================="

if [ "$TOTAL" -eq 10 ]; then
    echo "🎉 All tests passed!"
    exit 0
else
    echo "⚠️ Some tests failed."
    exit 1
fi
