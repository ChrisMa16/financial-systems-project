# Report Documentation

## Unpaid Client Balance Report

### Purpose
This report shows unpaid invoice balances by client and matter to support billing follow-up, collections, and financial review.

### Tables Used

- clients
- matters
- invoices
- payments

### Columns Included

- client_name
- matter_name
- invoice_id
- invoice_date
- due_date
- days_overdue
- amount_billed
- invoice_status
- total_paid
- remaining_balance

### Business Logic

- The remaining balance on an account is found by comparing the initial amount billed to the amount that has been paid so far.
- COALESCE is used so invoices with no payments are treated as having a total paid amount of 0.
- Only invoices with open balances are shown because the report is meant to help departments follow up with clients who still owe money.
- Void invoices are excluded because they are kept for audit history and are not part of normal billing or collections activity.
- Results are sorted by remaining balance so the business can quickly identify the clients or invoices with the highest amount owed.

### Business Value

This report helps billing, finance, and management teams identify clients with the highest unpaid balances so they can prioritize follow-up, collections, and account review.

### Future Improvements

- Decide how to handle negative days_overdue values for invoices that are not due yet.
- Add aging buckets such as 0-30 days, 31-60 days, 61-90 days, and 90+ days overdue.
- Add calculated payment labels such as Unpaid, Partially Paid, Paid, and Overdue.
- Add a Python script to export the report results to a CSV file.
- Add summary totals by client for management review.