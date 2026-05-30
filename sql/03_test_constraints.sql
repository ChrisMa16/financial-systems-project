-- 03_test_constraints.sql
-- Purpose: Test that database constraints reject invalid financial system data.
-- These INSERT statements are expected to fail.


-- TEST 1: Reject matter with fake client_id

INSERT INTO matters(client_id, matter_name, practice_area, open_date, status)
VALUES (999, 'Contract Review for Vendor Agreement', 'Corporate Law', '2026-05-21', 'Open');

-- Test 2: Reject invoice with negative amount_billed

INSERT INTO invoices(matter_id, invoice_date, due_date, amount_billed, status)
VALUES(1,'2026-05-21', '2026-06-20', -500.00, 'Open' );

-- Test 3: Reject invoice with invalid status

INSERT INTO invoices(matter_id, invoice_date, due_date, amount_billed, status)
VALUES(1,'2026-05-21', '2026-06-20', 1200.00, 'Pending' );

-- Test 4: Reject payment with invalid payment method

INSERT INTO payments(invoice_id, payment_date, amount_paid, payment_method)
VALUES(2, '2026-05-25', 500.00, 'Bitcoin');

-- Test 5: Reject payment with fake invoice_id

INSERT INTO payments(invoice_id, payment_date, amount_paid, payment_method)
VALUES(999, '2026-05-25', 100.00, 'Credit Card');

-- Test 6: Reject expense with negative amount

INSERT INTO expenses(matter_id, expense_date, expense_category, amount, vendor)
VALUES (1, '2026-05-26', 'Filing Fee', -75.00, 'Santa Clara County Court');

-- Test 7: Reject expense with invalid expense_category

INSERT INTO expenses(matter_id, expense_date, expense_category, amount, vendor)
VALUES (1, '2026-05-26', 'Office Party', 150.00, 'Local Catering Co.');

-- Test 8: Reject invoice where due_date is before invoice_date

INSERT INTO invoices(matter_id, invoice_date, due_date, amount_billed, status)
VALUES(1, '2026-06-20', '2026-05-21', 800.00, 'Open');