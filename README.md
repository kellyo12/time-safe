 TimeSafe Smart Contract

**TimeSafe** is a Clarity smart contract that allows users to securely lock STX tokens until a specified block height. Once the unlock time is reached, the designated recipient can withdraw the locked funds in a trustless and verifiable manner.

---

 Key Features

-  Lock STX funds for a specified period (based on block height)
-  Enforces a time-delay release mechanism
-  Assign a recipient to claim funds after unlock
-  Transparent, auditable vault state on-chain
-  Single-use withdrawal logic to prevent double claims

---

 Contract Functions

| Function             | Type         | Description                                                   |
|----------------------|--------------|---------------------------------------------------------------|
| `lock-funds`         | `public`     | Lock a specific amount of STX until a target block height     |
| `withdraw-funds`     | `public`     | Recipient can withdraw after unlock block is reached          |
| `get-vault`          | `read-only`  | Returns details of the time-locked vault for a given ID       |
| `get-vault-owner`    | `read-only`  | Returns the owner of a specific vault                         |
| `get-current-block`  | `read-only`  | Returns the current block height for reference                |

---
 Usage Example

```clarity
;; Lock 1_000_000 uSTX until block 10000 for recipient
(lock-funds 'ST123...recipient u1000000 u10000)

;; After block 10000, recipient can withdraw
(withdraw-funds u0)
