# Data Warehouse Project

A data warehouse I built to learn data engineering fundamentals, following the "Data with Baraa" course, using T-SQL in Azure Data Studio.

## Overview

The project ingests data from 2 different sources (3 tables each) and moves it through a medallion architecture (bronze → silver → gold) to produce a clean, analytics-ready star schema.

## Bronze Layer : Raw Ingestion

- Pulls data from the source systems and bulk inserts it as-is into tables under a dedicated bronze schema.
- No transformations here, the goal is just to land the raw data reliably.
- Delivered as a stored procedure that handles the full ingestion.

## Silver Layer : Cleaning & Transformation

- Truncates and reloads tables from bronze, applying transformations along the way:
  - Trimming/handling extra spaces
  - Handling missing values
  - Fixing incorrect data types
  - Deriving new columns and enriching existing data
  - Using window functions for row-level logic
- Also delivered as a stored procedure.

## Gold Layer : Business-Ready Model

- Models the cleaned data into a star schema: 2 dimension tables and 1 fact table.
- Built as views rather than physical tables.
- Combines and integrates the data using left joins across the dimensions and fact.

## Tech Used

T-SQL, Azure Data Studio, SQL Server

## Status

Complete. This was my first hands-on project in data engineering, built to learn the fundamentals of a medallion architecture end-to-end.
