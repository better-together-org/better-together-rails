# Billing on this host app

The Community Engine billing stack is bundled with the gem and stays closed until the host switches it on.

## Environment

| Variable | Purpose |
|----------|---------|
| `BT_BILLING_ENABLED` | `true` mounts the billing routes and registers the recurring billing jobs |
| `PAY_BUSINESS_NAME`, `PAY_BUSINESS_ADDRESS` | Required, printed on invoices and receipts |
| `PAY_SUPPORT_EMAIL` | Required, or set `DEFAULT_FROM_EMAIL` |
| `BT_BILLING_DEFAULT_CURRENCY`, `BT_BILLING_DEFAULT_COUNTRY` | Plan form preselect and processor country |

Encryption keys: each environment keeps `active_record_encryption` (primary_key, deterministic_key, key_derivation_salt) in its encrypted credentials. Losing them makes the encrypted billing fields unreadable.

## Upgrading

`bin/rails better_together:install:migrations`, then `db:migrate` (the Dokku release phase does this).
Pay 12 and receipts 3 come in through the gem; there is no processor account needed for the local methods
(cash, cheque, e-transfer).
