# Client/Matter Billing and Collections Reporting System

## Project Overview

This project is a law-firm-style financial system that tracks clients, matters, invoices, payments, expenses, and unpaid balances. It helps billing, finance, and management teams review client accounts, monitor outstanding balances, and support billing follow-up and collections.

## Project Purpose

The purpose of this project is to demonstrate SQL database design, financial data modeling, data integrity rules, and reporting for a law-firm-style financial system. The project focuses on organizing client, matter, invoice, payment, and expense data so financial teams can track balances, review billing activity, and support collections decisions.

## Current Functionality

- Tracks clients, matters, invoices, payments, and expenses.
- Enforces financial data rules using database constraints.
- Tests invalid data scenarios to confirm the database rejects bad records.
- Generates an unpaid client balance report.
- Calculates total paid and remaining balance for each invoice.
- Identifies open balances for billing follow-up and collections review.

## Tools and Technologies

- PostgreSQL
- SQL
- VS Code
- Terminal
- Markdown

## Project Structure

- README.md: Main project overview and documentation.
- docs/: Contains business rules and report documentation.
- sql/: Contains database setup, sample data, constraint tests, and report queries.
- python/: Reserved for future Python automation and CSV export scripts.

## Phase 1 Status

Phase 1 is complete. In this phase, the project database was created with tables for clients, matters, invoices, payments, and expenses. Sample data was inserted, database constraints were tested, and the first financial report was built.

The completed report identifies unpaid client balances by showing invoice amounts, total payments, remaining balances, and days overdue. Documentation was also added to explain the business rules and report logic.

## Next Steps

- Build additional financial reports for billing and management review.
- Add aging buckets for overdue invoices.
- Add client-level summary totals.
- Create Python scripts to export report results to CSV.
- Add final screenshots and resume-focused documentation.