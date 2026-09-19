/*
Stored Procedure: Load Bronze Layer

this stored procedure loads data into the 'bronze' schema from external csv files.
BY:
- truncating the bronze tables before loading data.
- Uses the BULK INNSERT command to load data from csv files to bronze tables

This procedure doesnt accept any parameters nor return any values.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY 
        SET @batch_start_time = GETDATE();
        PRINT '====================';
        PRINT 'Loading Bronze Layer';
        PRINT '====================';


        PRINT 'Loading CRM Tables';
        PRINT '--------------------'; 

        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info
        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/data/import/cust_info.csv'
        WITH (
            FIRSTROW =2,
            FIELDTERMINATOR= ',',
            TABLOCK 
            );
        SET @end_time = GETDATE();
        PRINT '>> cust_info Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
        PRINT '>>--------------------'; 




        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info
        BULK INSERT bronze.crm_prd_info
        FROM '/var/opt/mssql/data/import/datasets/source_crm/prd_info.csv'
        WITH (
            FIRSTROW =2,
            FIELDTERMINATOR= ',',
            TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT '>> prd_info Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
        PRINT '>>--------------------';



        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details
        BULK INSERT bronze.crm_sales_details
        FROM '/var/opt/mssql/data/import/datasets/source_crm/sales_details.csv'
        WITH (
            FIRSTROW =2,
            FIELDTERMINATOR= ',',
            TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT '>> sales_details Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
        PRINT '>>--------------------';



        PRINT 'Loading ERP Tables';
        PRINT '------------------';


        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12
        BULK INSERT bronze.erp_cust_az12
        FROM '/var/opt/mssql/data/import/datasets/source_erp/cust_az12.csv'
        WITH (
            FIRSTROW =2,
            FIELDTERMINATOR= ',',
            TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT '>> cust_az12 Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
        PRINT '>>--------------------';



        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101
        BULK INSERT bronze.erp_loc_a101
        FROM '/var/opt/mssql/data/import/datasets/source_erp/loc_a101.csv'
        WITH (
            FIRSTROW =2,
            FIELDTERMINATOR= ',',
            TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT '>> loc_a101 Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
        PRINT '>> ---------------'




        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/var/opt/mssql/data/import/datasets/source_erp/px_cat_g1v2.csv'
        WITH (
            FIRSTROW =2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> px_cat_g1v2 Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
        PRINT '>>--------------------';



        SET @batch_end_time=GETDATE();
        PRINT 'Bronze layer load completed.'
        PRINT 'Batch Duration: ' +CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) +' seconds';
        PRINT '============================'
    END TRY
    BEGIN CATCH
        PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE' + CAST (ERROR_STATE() AS NVARCHAR);
    END CATCH 
END
