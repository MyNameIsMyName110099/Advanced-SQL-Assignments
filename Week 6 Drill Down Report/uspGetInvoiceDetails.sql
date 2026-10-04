USE AP;
GO


-- ============================================================================
-- Week 6 - Drill Down Report
-- Feeds APInvoiceDrillDown.rdl with the AP.dbo.Invoices table.
--
-- @InvoiceID is optional: leave it NULL (or do not pass it) to get every
-- invoice, or pass an InvoiceID to get just that invoice. It is INT because
-- InvoiceID is an INT identity column. Rows come back ordered by VendorID so
-- the report's Vendor parent group reads in order.
-- ============================================================================
CREATE OR ALTER PROCEDURE dbo.uspGetInvoiceDetails
	@InvoiceID INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	InvoiceID,
			VendorID,
			InvoiceNumber,
			InvoiceDate,
			InvoiceTotal,
			PaymentTotal,
			CreditTotal,
			TermsID,
			InvoiceDueDate,
			PaymentDate
	FROM	dbo.Invoices
	WHERE	@InvoiceID IS NULL
		OR	InvoiceID = @InvoiceID
	ORDER BY VendorID, InvoiceID;
END;
GO


-- Test: every invoice, then a single invoice
EXEC dbo.uspGetInvoiceDetails;
EXEC dbo.uspGetInvoiceDetails @InvoiceID = 5;
