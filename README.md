# ATM in VHDL

## Project Overview

This project implements an **Automated Teller Machine (ATM)** using **VHDL** on an **FPGA board**. The ATM supports basic banking operations such as balance inquiry, cash withdrawal, money deposit, and PIN reset for up to **four different cards/accounts**. The system follows a structured design approach, dividing control and execution into distinct units.

## Features

- **Card Authentication**: Users enter their **card number** and **PIN code** for access.
- **Balance Inquiry**: Displays the current balance of the selected account.
- **Cash Withdrawal**: Withdraws a specified amount (up to **1,000 EUR per transaction**), verifies the availability of funds, and dispenses banknotes.
- **Money Deposit**: Allows users to deposit money by entering banknotes individually.
- **PIN Reset**: Enables users to change their PIN after verification.

## System Design

### 1. **Black Box Model**
The system is designed with a **Control Unit (CU)** and an **Execution Unit (EU)**. Inputs and outputs are categorized as follows:

#### **Inputs:**
- **Data Inputs**: Card number, PIN code, transaction amounts.
- **Control Inputs**: START, CONFIRM, EXIT buttons, command selection.

#### **Outputs:**
- **Data Outputs**: Display balance, transaction amount, and messages.
- **Control Outputs**: LED indicators for navigation, permission signals for execution.

---

### 2. **Component Breakdown**

#### **Control Unit (CU)**
- Implements the ATM's **state machine** using a **two-process architecture**.
- Manages transitions, command selection, and synchronization.

#### **Execution Unit (EU)**
- Handles **data storage and operations** based on control signals.

#### **Key Components:**
1. **Big Register**: Stores **card number, PIN code, and account balance**.
2. **Temporary PIN Register**: Holds the PIN entered for authentication.
3. **Seven-Segment Display**: Displays messages, amounts, and PIN input.
4. **Keypad Decoder**: Converts user keypad input into a usable format.
5. **Debouncer**: Ensures clean button presses.
6. **MUX 4:1**: Selects the correct card's balance and PIN.
7. **PIN Comparator**: Compares entered PIN with stored values.
8. **Greedy Algorithm for Banknote Separation**: Optimally selects banknotes for withdrawals.
9. **Rolling Display**: Shows banknotes dispensed.
10. **Vending Register**: Stores the ATM’s total available cash.
11. **Counters & Adders**: Manage deposited banknotes.
12. **BCD & Binary Converters**: Handle number format conversions.

---

### 3. **Control Flow**
- The **ATM starts in an IDLE state**.
- Upon **card selection and PIN entry**, the system transitions to the main menu.
- The selected operation (balance check, withdrawal, deposit, PIN reset) determines the next steps.
- Transactions **update registers**, ensuring consistency between the account balance and available cash.

---

## User Guide

### **Using the ATM**
1. **Insert the Card**: Choose a **card number** using the first two switches and press **CONFIRM**.
2. **Enter PIN**: Input a **4-digit PIN** on the keypad.
3. **Select an Operation**:
   - **1**: Balance Inquiry → Displays balance.
   - **2**: Withdrawal → Enter amount, verify funds, and dispense cash.
   - **3**: Deposit → Input banknotes individually.
   - **4**: PIN Reset → Enter old PIN, set a new one.
4. **Confirm & Exit**: After completing a transaction, exit by pressing **CONFIRM** or **EXIT**.

---

## Implementation Details

- **VHDL Modules**: Each functionality is implemented as a separate VHDL module.
- **Top-Down Approach**: The system was first designed abstractly and then implemented in hardware.
- **Testing**: Simulated using **test benches** and debugged on an FPGA.
