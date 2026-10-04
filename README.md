# Advanced SQL - Individual Assignments

Mason Romdenne - NWTC Advanced SQL, Fall 2026

## Week 5

| Folder | Package | What it does |
|---|---|---|
| [Week 5 SSIS Employee Table Extract](Week%205%20SSIS%20Employee%20Table%20Extract) | `EmployeeExtract.dtsx` | Extracts `AdventureWorks2022.HumanResources.Employee` to `EmployeeExtract_yyyymmdd.csv` |
| [Week 5 SSIS Import](Week%205%20SSIS%20Import) | `CurrencyDataImport.dtsx` | Loads `SampleCurrencyData.txt` into `AdventureWorks2022.dbo.Week5_SSIS_Import` (table script: `Week5_SSIS_Import.sql`) |

### Running on another machine

Open the `.sln`, then in the package's **Variables** window change only:

- `ServerName` and `DatabaseName` - the connection string is built from these by an expression
- `OutputFolder` (extract) or `SourceFolder` (import) - the folder the file is written to / read from

Everything else (connection string, file name with today's date, full file path, truncate
statement) is built by expressions from those variables. If the machine does not have the
Microsoft OLE DB Driver for SQL Server, change `OleDbProvider` (for example to `MSOLEDBSQL19.1`).

For the import, run `Week5_SSIS_Import.sql` first to create the table.

## Week 6

| Folder | Report | What it does |
|---|---|---|
| [Week 6 Drill Down Report](Week%206%20Drill%20Down%20Report) | `APInvoiceDrillDown.rdl` | SSRS drill-down of `AP.dbo.Invoices`: one row per Vendor ID, click `+` to see that vendor's invoices |

### Running it

1. Run `uspGetInvoiceDetails.sql` in SSMS to create `dbo.uspGetInvoiceDetails` in the AP database.
2. Open `APInvoiceDrillDown.sln` in Visual Studio and preview `APInvoiceDrillDown.rdl`.
   The shared data source `AP.rds` points at server `ADVSQL`, database `AP` (Windows authentication).

The **Invoice ID** parameter is optional. Leave it NULL to load every invoice (vendors start collapsed),
or enter an Invoice ID to load just that invoice (its vendor starts expanded).
