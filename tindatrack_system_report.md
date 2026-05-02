# TindaTrack: System Architecture & Feature Walkthrough

## 1. Executive Summary

**TindaTrack** is a high-performance, offline-first Point of Sale (POS) and Inventory Management system explicitly engineered for the unique workflows of Philippine sari-sari stores. It handles high-volume "tingi" (retail/loose) transactions, unpredictable supply runs, and spot-check counting methods, all without requiring an active internet connection.

---

## 2. System Architecture & State Management

### Technology Stack

* **Framework:** Flutter (Dart) for high-performance cross-platform rendering.

* **State Management:** Riverpod 3.x. The entire app relies heavily on `.autoDispose` providers (`AutoDisposeNotifier`, `Provider.autoDispose`, etc.) to ensure strict memory hygiene. State is dynamically allocated when screens open and instantly garbage-collected when they close, preventing memory leaks during long POS shifts.

* **Database Engine:** Drift (formerly Moor). A robust, reactive wrapper around SQLite that provides compile-time query verification, atomic batch transactions, and seamless schema migrations.

### Scanner Lifecycle Handling

Barcode scanning via `mobile_scanner` is a high-risk operation on lower-end Android devices. If a scanner is improperly disposed of or spams events, it causes thread deadlocks (the "Ghost Scan" bricking).

* **The Fix:** TindaTrack uses a non-blocking lifecycle. We abandoned `controller.stop()` in the `onDetect` callback (which caused native `HandlerThread` locks) in favor of a logical UI boolean lock (`_isLocked = true`). The controller is allowed to naturally dispose via the main thread lifecycle when `Navigator.pop` is executed, completely eliminating ANRs.

* **Continuous POS Scanning:** In the continuous POS mode, we implement a strict 1.5s lock/debounce cooldown after detection. The scanner reads a code, locks, adds to the cart, plays a haptic/audio beep, waits 1.5s, and unlocks. This prevents the callback from firing 30 times a second and thrashing the state.

---

## 3. Database Schema (Drift)

TindaTrack's local schema is built for speed and auditability.

### The `Products` Table

The master catalog. It supports both barcoded and unbarcoded (loose) items.

* `id` (Text): Unique UUID.

* `currentStock` (Real): The live digital count. Allowed to go negative if physical sales outpace recorded deliveries.

* `reorderPoint` (Real): Threshold for the "Low Stock" warnings.

* `isSeeded` (Bool): **Developer Mode Flag**. Automatically defaults to `false`. Seeded database masters are imported as `true`. New products scanned by users default to `false` so they can be filtered and exported.

### The `SalesTransactions` Table (v2 Ledger)

Tracks every POS checkout for the Daily Ledger.

* `id` (Int/AutoIncrement).

* `timestamp` (DateTime): Indexed for rapid daily filtering.

* `totalAmount` (Real): The grand total of the transaction.

* `itemsSnapshot` (Text): A human-readable, immutable string of the cart at checkout (e.g., `"2x Coke, 1x Century Tuna, Misc PHP 5.00"`).

---

## 4. Core Workflows (User Walkthrough)

### 1. Stock-In (Tanggap Delivery)

When new inventory arrives, the user scans the item, inputs the delivery quantity, and enters the total cost. The system automatically recalculates the `averageCost` (Puhunan) using a weighted average. This ensures the profit margins remain accurate even if wholesale prices fluctuate.

### 2. The POS / Cashier Flow

The heart of the app. Built for speed:

* **Continuous Scanner:** The camera stays open, allowing rapid sequential scanning with a 1.5-second debounce.

* **Quick-Tap & Search:** Cashiers can manually search for unbarcoded items or select them from quick-access UI grids.

* **"Misc Item" Open-Price:** A dedicated "Misc" button allows the cashier to instantly add an open cash amount (e.g., PHP 5 for a loose pinch of garlic). This synthesizes a dummy `CartItem` in memory without polluting the database.

* **Atomic Checkout:** The final "Charge" button triggers a Drift Batch Transaction. It safely iterates through the cart, bypassing stock deduction for "Misc" items, executing raw SQL `UPDATE`s for stock, and inserting records into both the `AuditLog` and `SalesTransactions` tables—all in one unbreakable atomic commit.

### 3. The Evening Count (Imbentaryo)

Instead of rigidly demanding stock-ins for every item, the system accommodates reality. If a user spots a discrepancy on the shelf, they initiate a Physical Count.

* The actual counted quantity completely **supersedes** the digital record.

* If physical stock is lower than expected, the system calculates the variance (Shrinkage) and logs it.

* The system gracefully handles **Negative Stock**: If a cashier sells items that haven't been stocked-in yet, `currentStock` goes below zero. The Evening Count resets this back to reality.

### 4. Reports & Ledger (Benta at Puhunan)

The Reports dashboard provides live financial health metrics:

* **In-Stock Value:** The sum of `currentStock * averageCost`.

* **Daily Ledger:** Replaces legacy static metrics. Users can select any day via a calendar picker. The system queries the `SalesTransactions` table using `isBetweenValues` to aggregate the total sales and render a chronological receipt feed.

### 5. Developer Mode

To facilitate rapid deployment for new clients, a data-collection engine is built in:

* Users scan new, unlisted items in their store. These default to `isSeeded = false`.

* A **"Bagong Paninda"** filter chip allows isolation of these specific user-created items.

* In Settings, tapping **"Export Bagong Paninda"** generates a properly indented, parseable JSON array of all unseeded products using `share_plus` to export a `.txt` file for our backend engineers.

---

## 5. Technical Edge Cases Resolved

Throughout development, TindaTrack was subjected to a "ruthless audit" approach, yielding the following critical stability fixes:

1.  **Isolate Overhead Removal:** Search operations were originally offloaded to `Isolate.run()`. We found the spin-up overhead of Isolates actually *caused* UI stuttering for small datasets. We reverted to a highly optimized, synchronous main-thread `.where()` filter with an intelligent `_lastQuery` cache, resulting in instant, real-time keystroke filtering.
2.  **The "Ghost Scan" Bricking:** Native camera threads were deadlocking when `controller.stop()` collided with `Navigator.pop()`. We implemented the `_isLocked` boolean guard, ensuring strictly asynchronous, non-blocking camera tear-downs.
3.  **UI Debouncing & State Leaks:** POS cart state leaked across sessions. By enforcing `NotifierProvider.autoDispose` on all transactional state, the cart is guaranteed to wipe itself clean the moment the POS route is closed.
4.  **Drift Thread Atomicity:** Replaced standard Riverpod loop mutations with raw SQL `customStatement('UPDATE products SET current_stock = current_stock - ? WHERE id = ?')` inside Drift batch transactions. This prevents race conditions where a concurrent database read/write during checkout could corrupt the stock count.
5.  **State Collisions in Filters:** The Developer Mode UI filter (`_showNewOnly`) was colliding with the "In-Store Only" (`currentStock > 0`) filter, hiding newly scanned 0-stock items. We refactored the Riverpod `.where()` block to make the `Bagong Paninda` filter mutually exclusive, overriding stock requirements safely.
