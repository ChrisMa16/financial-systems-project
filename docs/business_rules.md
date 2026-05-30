# Business Rules

## Purpose

Document the financial and data integrity rules used by the Client/Matter Billing and Collections Reporting System.

## Client and Matter Rules

- A client can have many matters.
- Each matter must belong to one existing client.
- Client status must be either Active or Closed.
- Matter status must be Open, Closed, or On Hold.
- Every matter should describe the type of work being handled for the client.

## Invoice Rules

- Each invoice must belong to one existing matter.
- Invoice status must be Open, Closed, or Void.
- Invoice amount must be required and cannot be negative.
- Invoice due date must be after the invoice date.
- Void invoices are kept for audit/history purposes.

## Payment Rules

- Each payment must belong to one existing invoice.
- Payment amount must be required and cannot be negative.
- Payment method must be one of the approved payment methods.
- Payments cannot be applied to Void invoices.
- Payments should not exceed the invoice's remaining balance.
- When total payments equal the invoice amount, the invoice should be considered fully paid.

## Expense Rules

- Each expense must belong to one existing matter.
- Expense amount must be required and cannot be negative.
- Expense category must be one of the approved expense categories.
- Vendor must be required for every expense.
- Expenses are tracked at the matter level so the firm can identify costs connected to each client matter.

## Reporting Rules

- Reports should support billing, collections, reconciliation, and management review.
- Unpaid balance reports should exclude Void invoices.
- Remaining balance is calculated as the invoice amount minus total payments.
- Invoices with no payments should show total paid as 0.
- Reports should show both client-level and invoice-level financial details when needed.
- Report results should be sorted in a way that highlights the most important financial issues first.