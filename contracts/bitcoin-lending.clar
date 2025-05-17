;; BitLend: Bitcoin-Backed Lending Protocol on Stacks
;;
;; A decentralized lending platform enabling users to borrow against their
;; Bitcoin collateral with customizable risk parameters and automated
;; liquidation protection.
;;
;; This protocol enables:
;;  - BTC collateralized loans on Stacks Layer 2
;;  - Variable interest rates and collateral requirements 
;;  - Transparent liquidation mechanism to protect the protocol
;;  - Full on-chain governance for platform parameters

;; Constants

;; Platform ownership
(define-constant CONTRACT-OWNER tx-sender)

;; Error codes
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-COLLATERAL (err u101))
(define-constant ERR-BELOW-MINIMUM (err u102))
(define-constant ERR-INVALID-AMOUNT (err u103))
(define-constant ERR-ALREADY-INITIALIZED (err u104))
(define-constant ERR-NOT-INITIALIZED (err u105))
(define-constant ERR-INVALID-LIQUIDATION (err u106))
(define-constant ERR-LOAN-NOT-FOUND (err u107))
(define-constant ERR-LOAN-NOT-ACTIVE (err u108))
(define-constant ERR-INVALID-LOAN-ID (err u109))
(define-constant ERR-INVALID-PRICE (err u110))
(define-constant ERR-INVALID-ASSET (err u111))

;; Supported assets
(define-constant VALID-ASSETS (list "BTC" "STX"))

;; Data Variables

;; Platform state
(define-data-var platform-initialized bool false)

;; Risk parameters
(define-data-var minimum-collateral-ratio uint u150) ;; 150% collateral ratio
(define-data-var liquidation-threshold uint u120) ;; 120% triggers liquidation
(define-data-var platform-fee-rate uint u1) ;; 1% platform fee

;; Platform metrics
(define-data-var total-btc-locked uint u0)
(define-data-var total-loans-issued uint u0)

;; Data Maps

;; Loan details storage
(define-map loans
  { loan-id: uint }
  {
    borrower: principal,
    collateral-amount: uint,
    loan-amount: uint,
    interest-rate: uint,
    start-height: uint,
    last-interest-calc: uint,
    status: (string-ascii 20),
  }
)

;; User loan tracking
(define-map user-loans
  { user: principal }
  { active-loans: (list 10 uint) }
)

;; Asset price oracle
(define-map collateral-prices
  { asset: (string-ascii 3) }
  { price: uint }
)