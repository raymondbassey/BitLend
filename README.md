# **BitLend: Bitcoin-Backed Lending Protocol on Stacks**

![BitLend Architecture Diagram](https://via.placeholder.com/800x400.png?text=BitLend+System+Architecture)

**BitLend** is a decentralized, non-custodial lending protocol built on the [Stacks blockchain](https://www.stacks.co/), enabling users to borrow against their Bitcoin (BTC) holdings with on-chain transparency, automated risk management, and dynamic governance controls.

## 🚀 Overview

BitLend allows Bitcoin holders to unlock liquidity without selling their BTC. Users deposit BTC as collateral and borrow stablecoins or synthetic assets, all managed through Clarity smart contracts on the Stacks Layer 2.

### 🔑 Key Features

* 🪙 **Bitcoin Collateralization**: Secure loans backed by BTC via Stacks L2 bridges.
* 📉 **Dynamic Risk Parameters**: Adjustable collateral ratios and liquidation thresholds.
* 🔄 **Automated Liquidation**: Triggered by real-time price feeds if ratios fall below safety limits.
* 🗳️ **Decentralized Governance**: Protocol parameters managed via on-chain proposals and voting.
* 📊 **Transparent Accounting**: Live visibility into loan positions and system metrics.

## 🏗️ Architecture

### System Layers

```plaintext
+---------------------------+
|     Frontend DApp (UI)    |
|   - Loan Dashboard        |
|   - Governance Interface  |
+------------+--------------+
             |
             v
+---------------------------+
|   Smart Contracts (Clarity)|
| - Loans & Collateral Logic|
| - Risk & Liquidation Engine|
| - Governance Parameters   |
+------------+--------------+
             |
             v
+---------------------------+
|     Oracle Network        |
| - BTC/USD Price Feeds     |
| - Multi-source Validation |
+------------+--------------+
             |
             v
+---------------------------+
| Bitcoin & Stacks Layer 1  |
| - BTC Held by Users       |
| - Stacks Executes Logic   |
+---------------------------+
```

## 🔧 Core Functionality

### 🏦 Collateral Management

```clarity
(define-public (deposit-collateral (amount uint)))
```

* Accepts BTC via L2 bridges
* Tracks and updates `total-btc-locked`
* Enforces minimum collateral ratio (150%)

### 💸 Loan Lifecycle

1. **Create Position**

   ```clarity
   (define-public (request-loan (collateral uint) (loan-amount uint)))
   ```

   * Requires 150% collateralization
   * Generates unique `loan-id`
   * Stores data in `loans` map

2. **Interest Accrual**

   ```clarity
   (define-private (calculate-interest ...))
   ```

   * Accrues interest per block
   * Updates `last-interest-calc` on loan interaction

3. **Liquidation Trigger**

   ```clarity
   (define-private (check-liquidation (loan-id uint)))
   ```

   * Monitors LTV using oracle data
   * Triggers liquidation below 120% ratio

### 🔐 Governance Controls

```clarity
(define-public (update-collateral-ratio (new-ratio uint)))
(define-public (update-liquidation-threshold (new-threshold uint)))
```

* Time-locked changes for critical settings
* DAO upgrade path for community control

## 🧠 Smart Contract Details

### 📁 Data Structures

```clarity
(define-map loans { loan-id: uint } {
  borrower: principal,
  collateral-amount: uint,
  loan-amount: uint,
  interest-rate: uint,
  start-height: uint,
  last-interest-calc: uint,
  status: (string-ascii 20)
})
```

### 🔢 State Variables

| Variable                   | Type   | Description              |
| -------------------------- | ------ | ------------------------ |
| `minimum-collateral-ratio` | `uint` | Set to 150%              |
| `liquidation-threshold`    | `uint` | Liquidation at 120%      |
| `platform-fee-rate`        | `uint` | 1% protocol fee on loans |

## 🔍 Function Summary

### 📤 Public Functions

| Function                       | Description                            |
| ------------------------------ | -------------------------------------- |
| `initialize-platform`          | Launches the protocol                  |
| `deposit-collateral`           | Deposits BTC to open/maintain position |
| `request-loan`                 | Opens a new loan against deposited BTC |
| `repay-loan`                   | Closes position, returns collateral    |
| `update-collateral-ratio`      | Sets new min ratio (admin only)        |
| `update-liquidation-threshold` | Adjusts liquidation margin             |
| `update-price-feed`            | Sets asset prices (oracle function)    |

### 📄 Read-Only Functions

| Function             | Description                              |
| -------------------- | ---------------------------------------- |
| `get-loan-details`   | View data for a specific loan ID         |
| `get-user-loans`     | Lists all loans associated with user     |
| `get-platform-stats` | Shows total BTC locked and key variables |
| `get-valid-assets`   | Lists assets approved as collateral      |

## 🔐 Security & Risk Mitigation

### ✅ Oracle Protections

* Aggregated price feeds from multiple providers
* Minimum update frequency required
* Emergency price freeze mechanism in case of oracle failure

### 🛡 Protocol Safeguards

* 150% over-collateralization requirement
* Liquidation incentives to reduce bad debt
* Circuit breaker for extreme volatility

### 👤 User Protections

* Real-time health monitoring
* Notification window before liquidation (future)
* Partial liquidation support (planned)

### 🧪 Audits & Verification

* Formal verification of Clarity logic
* Third-party audit pre-mainnet
* Bug bounty program at launch

## ⚙️ Usage Guide

### Requirements

* [Stacks.js v4+](https://docs.stacks.co/)
* [Clarinet SDK](https://github.com/hirosystems/clarinet)
* Bitcoin Testnet Wallet

## 🗳 Governance Process

| Step                       | Description                 |
| -------------------------- | --------------------------- |
| Proposal Submission        | Admin or DAO member submits |
| Voting Period              | 7-day community vote        |
| Time-Locked Enforcement    | Delay before activation     |
| Parameter Update Execution | Changes applied on-chain    |

### 🔢 Current Parameters

| Parameter             | Value | Last Updated |
| --------------------- | ----- | ------------ |
| Min Collateral Ratio  | 150%  | Block #12345 |
| Liquidation Threshold | 120%  | Block #12345 |
| Protocol Fee          | 1%    | Genesis      |

## 📌 Summary

BitLend bridges the power of Bitcoin with the programmability of Stacks, offering secure, decentralized lending with real-time risk control and transparent on-chain governance.
