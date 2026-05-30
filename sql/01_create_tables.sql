-- This file contains the SQL statements to create the necessary tables for our financial systems project

-- Clients table
CREATE TABLE clients (
    client_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Active','Closed'))
);

-- Matters table
CREATE TABLE matters (
    matter_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id INT NOT NULL REFERENCES clients(client_id),
    matter_name VARCHAR(100) NOT NULL,
    practice_area VARCHAR(100) NOT NULL,
    open_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Open', 'Closed', 'On Hold'))
);

-- Invoices table
CREATE TABLE invoices (
    invoice_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matter_id INT NOT NULL REFERENCES matters(matter_id),
    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL CHECK (due_date > invoice_date),
    amount_billed NUMERIC(10,2) NOT NULL CHECK (amount_billed >= 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('Open', 'Closed', 'Void'))
); 

-- Payments table
CREATE TABLE payments (
    payment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    invoice_id INT NOT NULL REFERENCES invoices(invoice_id),
    payment_date DATE NOT NULL,
    amount_paid NUMERIC(10,2) NOT NULL CHECK (amount_paid >= 0),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('Cash', 'Check', 'Credit Card', 'ACH', 'Wire Transfer', 'Online Payment'))
);

-- Expenses table
CREATE TABLE expenses (
    expense_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matter_id INT NOT NULL REFERENCES matters(matter_id),
    expense_date DATE NOT NULL,
    expense_category VARCHAR(100) NOT NULL CHECK (expense_category IN ('Filing Fee', 'Legal Research', 'Courier',
   'Printing', 'Travel', 'Supplies', 'Other')),
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    vendor VARCHAR(100) NOT NULL
);