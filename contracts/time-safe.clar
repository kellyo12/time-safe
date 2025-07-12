;; TimeSafe - A time-locked STX vault

(define-map locks
  { user: principal }
  {
    amount: uint,
    unlock-block: uint
  })

;; Lock STX until a future block height
(define-public (lock-funds (unlock-block uint) (amount uint))
  (let ((current-balance (stx-get-balance tx-sender)))
    (begin
      (asserts! (> amount u0) (err u100))
      (asserts! (> unlock-block stacks-block-height) (err u101))
      (map-set locks { user: tx-sender }
        { amount: amount, unlock-block: unlock-block })
      (ok { locked: amount, until: unlock-block })
    )))

;; Withdraw locked STX after unlock block
(define-public (withdraw)
  (let ((lock-data (unwrap! (map-get? locks { user: tx-sender }) (err u102))))
    (begin
      (asserts! (>= stacks-block-height (get unlock-block lock-data)) (err u103))
      (map-delete locks { user: tx-sender })
      (try! (stx-transfer? (get amount lock-data) (as-contract tx-sender) tx-sender))
      (ok { withdrawn: (get amount lock-data) })
    )))

;; Read-only: Check lock details
(define-read-only (get-lock (who principal))
  (map-get? locks { user: who }))
 