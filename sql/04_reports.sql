-- 04_reports.sql
-- Purpose: Business reporting queries for the Financial Systems project.
-- Report 1: Unpaid Client Balance Report
-- 
-- Purpose: Show unpaid client invoices, total payments received, remaining balances, and due date timing.
-- Tables used: clients, matters, invoices, payments.
-- Business use: Helps billing and collections staff identify invoices that still have money owed.

-- Layer 1: Connect clients, matters, and invoices
-- Purpose: Show which client owns each matter and which invoices belong to that matter.
-- This confirms the main billing relationship works before adding payments.

SELECT client_name, matter_name, invoice_id, invoice_date, due_date, amount_billed, invoices.status invoice_status
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id;


-- Layer 2: Add payments
-- Purpose: Connect payments to invoices so we can see how much has been paid.
-- Use LEFT JOIN so invoices with no payments still appear in the report.

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, amount_paid, invoices.status invoice_status 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id;


-- Layer 3: Calculate total paid
-- Purpose: Add up all payments for each invoice.
-- This handles invoices that may have multiple payments.

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status AS invoice_status, SUM(amount_paid) AS Total_paid 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
;

-- Layer 4: Calculate remaining balance
-- Purpose: Subtract total paid from amount billed to show how much is still owed. 

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status AS invoice_status, SUM(amount_paid) AS Total_paid, amount_billed - SUM(amount_paid) AS Remaining_balance 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
;

-- Layer 5: Filter unpaid invoices
-- Purpose: Show only invoices where the remaining balance is greater than zero.

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status AS invoice_status, SUM(amount_paid) AS Total_paid, amount_billed - SUM(amount_paid) AS Remaining_balance 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
HAVING (amount_billed - SUM(amount_paid)) > 0;

-- Layer 6: Handle invoices with no payments
-- Purpose: Treat missing payment totals as 0 so unpaid invoices still calculate correctly.

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status AS invoice_status, COALESCE(SUM(amount_paid),0) AS total_paid, amount_billed - COALESCE(SUM(amount_paid),0) AS remaining_balance 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
HAVING (amount_billed - COALESCE(SUM(amount_paid),0)) > 0;


-- Layer 7: Add days overdue
-- Purpose: Show how many days an unpaid invoice is past its due date.
-- CURRENT_DATE gives today's date.
-- Subtracting invoices.due_date from CURRENT_DATE calculates the number of days overdue.

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, (CURRENT_DATE - invoices.due_date) AS days_overdue, amount_billed, invoices.status AS invoice_status, COALESCE(SUM(amount_paid),0) AS total_paid, amount_billed - COALESCE(SUM(amount_paid),0) AS remaining_balance 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
HAVING (amount_billed - COALESCE(SUM(amount_paid),0)) > 0;

-- Layer 8: Sort unpaid balances
-- Purpose: Show the largest remaining balances first.
-- This helps the billing or collections team focus on the biggest unpaid amounts first.

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, (CURRENT_DATE - invoices.due_date) AS days_overdue, amount_billed, invoices.status AS invoice_status, COALESCE(SUM(amount_paid),0) AS total_paid, amount_billed - COALESCE(SUM(amount_paid),0) AS remaining_balance 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
HAVING (amount_billed - COALESCE(SUM(amount_paid),0)) > 0
ORDER BY remaining_balance DESC;

-- Layer 9: Clean up report column names
-- Purpose: Make the report easier to read with clear and consistent column names.
-- This helps the billing or collections team understand the report without needing to interpret raw SQL names.
-- Also final Report Query

SELECT client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, (CURRENT_DATE - invoices.due_date) AS days_overdue, amount_billed, invoices.status AS invoice_status, COALESCE(SUM(amount_paid),0) AS total_paid, amount_billed - COALESCE(SUM(amount_paid),0) AS remaining_balance 
FROM clients
JOIN matters
    ON clients.client_id = matters.client_id
JOIN invoices
    ON invoices.matter_id = matters.matter_id
LEFT JOIN payments
    ON payments.invoice_id = invoices.invoice_id
GROUP BY client_name, matter_name, invoices.invoice_id, invoices.invoice_date, invoices.due_date, amount_billed, invoices.status
HAVING (amount_billed - COALESCE(SUM(amount_paid),0)) > 0
ORDER BY remaining_balance DESC;