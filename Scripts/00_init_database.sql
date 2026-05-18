/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- ================================================
-- Drop and recreate the 'DataWarehouseAnalytics' database
-- ================================================
DROP DATABASE IF EXISTS DataWarehouseAnalytics;

-- Create the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;

USE DataWarehouseAnalytics;

-- Disable strict mode for this session (handles empty date values)
SET SESSION sql_mode = '';

-- ================================================
-- Create Schemas
-- Note: MySQL does not support CREATE SCHEMA separately; tables are prefixed with schema-like naming using the database itself.
-- Using 'gold_' prefix to simulate the gold schema.
-- ================================================

CREATE TABLE gold_dim_customers(
	customer_key INT,
	customer_id INT,
	customer_number VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country VARCHAR(50),
	marital_status VARCHAR(50),
	gender VARCHAR(50),
	birthdate DATE NULL,
	create_date DATE NULL
);

CREATE TABLE gold_dim_products(
	product_key INT,
	product_id INT,
	product_number VARCHAR(50),
	product_name VARCHAR(50),
	category_id VARCHAR(50),
	category VARCHAR(50),
	subcategory VARCHAR(50),
	maintenance VARCHAR(50),
	cost INT,
	product_line VARCHAR(50),
	start_date DATE NULL
);

CREATE TABLE gold_fact_sales(
	order_number VARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE NULL,
	shipping_date DATE NULL,
	due_date DATE NULL,
	sales_amount INT,
	quantity TINYINT,
	price INT
);

-- ================================================
-- Load gold_dim_customers
-- ================================================
TRUNCATE TABLE gold_dim_customers;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data-analytics-project/datasets/csv-files/gold.dim_customers.csv'
INTO TABLE gold_dim_customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- ================================================
-- Load gold_dim_products
-- ================================================
TRUNCATE TABLE gold_dim_products;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data-analytics-project/datasets/csv-files/gold.dim_products.csv'
INTO TABLE gold_dim_products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- ================================================
-- Load gold_fact_sales
-- ================================================
TRUNCATE TABLE gold_fact_sales;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data-analytics-project/datasets/csv-files/gold.fact_sales.csv'
INTO TABLE gold_fact_sales
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

show databases;