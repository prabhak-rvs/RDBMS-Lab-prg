-- ===========================================
-- CollegeDB Assignment
-- Complete the TODO sections only.
-- ===========================================

DROP DATABASE IF EXISTS CollegeDB;

CREATE DATABASE CollegeDB;

USE CollegeDB;

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(20),
    HOD VARCHAR(20)
);
