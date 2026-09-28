USE AdventureWorks2022;
GO


-- ============================================================================
-- Week 5 - SSIS Import
-- Table that CurrencyDataImport.dtsx loads SampleCurrencyData.txt into.
--
-- Each line of the file holds four values with no delimiter between them:
--
--     1.00070049USD9/3/05 0:001.001201442
--     |________||_||_________||_________|
--     AverageRate  |  CurrencyRateDate  EndOfDayRate
--            FromCurrencyCode
--
-- That is the same shape as Sales.CurrencyRate, so the columns are named after
-- its columns. The table holds exactly the four values in the file and nothing
-- else, so every row loads as it appears in the file.
-- ============================================================================
DROP TABLE IF EXISTS dbo.Week5_SSIS_Import;
GO

CREATE TABLE dbo.Week5_SSIS_Import (
	AverageRate			DECIMAL(18, 9)	NOT NULL,
	FromCurrencyCode	NCHAR(3)		NOT NULL,
	CurrencyRateDate	DATETIME		NOT NULL,
	EndOfDayRate		DECIMAL(18, 9)	NOT NULL
);
GO


-- ============================================================================
-- Why each datatype
--
-- AverageRate, EndOfDayRate   DECIMAL(18, 9)
--     Exchange rates near 1.0. The longest value in the file has nine decimal
--     places (1.001502253), so scale 9 keeps every digit. MONEY only keeps four
--     decimal places and would round 8 of the 10 rows, and FLOAT is
--     approximate, so neither would load the data exactly as it is in the file.
--
-- FromCurrencyCode   NCHAR(3)
--     ISO currency codes are always exactly three characters (USD), the same
--     type Sales.CurrencyRate uses.
--
-- CurrencyRateDate   DATETIME
--     The file carries a time on every date (9/3/05 0:00), so DATETIME keeps
--     it where DATE would drop it. Matches Sales.CurrencyRate.CurrencyRateDate.
-- ============================================================================


-- ============================================================================
-- TESTING - run after the package has executed.
-- ============================================================================

-- All ten rows, in file order by date.
SELECT AverageRate, FromCurrencyCode, CurrencyRateDate, EndOfDayRate
FROM dbo.Week5_SSIS_Import
ORDER BY CurrencyRateDate;
GO

-- Should return 10 rows loaded, dated 2005-09-03 through 2005-09-12.
SELECT
	RowsLoaded = COUNT(*),
	FirstDate  = MIN(CurrencyRateDate),
	LastDate   = MAX(CurrencyRateDate)
FROM dbo.Week5_SSIS_Import;
GO
