-- This file holds the sample data for the financial systems project

-- Sample Client

INSERT INTO clients (client_name, industry, status)
VALUES ('George Costanza', 'Architect', 'Active'); 

-- Sample Matter

INSERT INTO matters (client_id, matter_name, practice_area, open_date, status)
VALUES (1, 'Office Lease Dispute', 'Real Estate', '2026-05-20', 'Open');

-- Sample Invoice

INSERT INTO invoices (matter_id, invoice_date, due_date, amount_billed, status)
VALUES (1, '2026-05-21', '2026-06-20', 2500.00, 'Open');

-- Sample Payment

INSERT INTO payments (invoice_id, payment_date, amount_paid, payment_method)
VALUES (1, '2026-05-25', 500.00, 'Credit Card');

-- Sample Expense

INSERT INTO expenses (matter_id, expense_date, expense_category, amount, vendor)
VALUES (1, '2026-05-22', 'Legal Research', 175.50, 'Westlaw');