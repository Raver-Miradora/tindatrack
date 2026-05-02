import 'package:drift/drift.dart';

// Products Table
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get barcode => text().nullable()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get unit => text()();
  RealColumn get reorderPoint => real()();
  RealColumn get averageCost => real().withDefault(const Constant(0.0))();
  RealColumn get averageSellingPrice => real().nullable()();
  RealColumn get burnRatePerDay => real().withDefault(const Constant(0.0))();
  RealColumn get lastActualQuantity => real().withDefault(const Constant(0.0))();
  RealColumn get currentStock => real().withDefault(const Constant(0.0))(); 
  DateTimeColumn get lastCountedAt => dateTime().nullable()();
  DateTimeColumn get lastBurnRateUpdate => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isSeeded => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// StockInEvents Table
class StockInEvents extends Table {
  TextColumn get id => text()();
  TextColumn get supplierName => text()();
  DateTimeColumn get deliveryDate => dateTime()();
  TextColumn get loggedBy => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// StockInItems Table
class StockInItems extends Table {
  TextColumn get id => text()();
  TextColumn get stockInEventId => text().references(StockInEvents, #id)();
  TextColumn get productId => text().references(Products, #id)();
  RealColumn get quantity => real()();
  RealColumn get unitCost => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// CountSessions Table
class CountSessions extends Table {
  TextColumn get id => text()();
  TextColumn get countType => text()();
  TextColumn get countedBy => text().nullable()();
  DateTimeColumn get startedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// CountItems Table
class CountItems extends Table {
  TextColumn get id => text()();
  TextColumn get countSessionId => text().references(CountSessions, #id)();
  TextColumn get productId => text().references(Products, #id)();
  RealColumn get expectedQuantity => real()();
  RealColumn get actualQuantity => real()();
  RealColumn get variance => real()();
  TextColumn get varianceReason => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get countedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Alerts Table
class Alerts extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().nullable().references(Products, #id)();
  TextColumn get alertType => text()();
  TextColumn get severity => text()();
  TextColumn get message => text()();
  TextColumn get status => text().withDefault(const Constant('open'))(); 
  DateTimeColumn get triggeredAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get acknowledgedAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  DateTimeColumn get snoozeUntil => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Users Table
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get role => text()();
  TextColumn get pin => text()(); // Will be hashed via Crypto utility
  TextColumn get email => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// AuditLog Table
class AuditLog extends Table {
  TextColumn get id => text()();
  TextColumn get performedBy => text().nullable()();
  TextColumn get actionType => text()(); 
  TextColumn get targetType => text()();
  TextColumn get targetId => text()(); 
  TextColumn get beforeSnapshot => text().nullable()();
  TextColumn get afterSnapshot => text().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// CountDrafts Table for persistence
class CountDrafts extends Table {
  TextColumn get productId => text().references(Products, #id)();
  RealColumn get actualQuantity => real()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {productId};
}

// SalesTransactions Table (v2)
class SalesTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  RealColumn get totalAmount => real()();
  TextColumn get itemsSnapshot => text()();
  TextColumn get paymentMethod => text().withDefault(const Constant('CASH'))();
  IntColumn get shiftId => integer().nullable()();
}

// Customers Table (v4)
class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// UtangLedger Table (v4)
class UtangLedger extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text().references(Customers, #id)();
  RealColumn get amount => real()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get description => text().nullable()();
  IntColumn get shiftId => integer().nullable()();
  TextColumn get itemsSnapshot => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// StoreExpenses Table (v5)
class StoreExpenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  TextColumn get description => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  IntColumn get shiftId => integer().nullable()();
}

// CashierShifts Table (v6)
class CashierShifts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cashierName => text()();
  DateTimeColumn get startTime => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get endTime => dateTime().nullable()();
  RealColumn get openingFloat => real()();
  RealColumn get expectedClosingFloat => real().nullable()();
  RealColumn get actualClosingFloat => real().nullable()();
  RealColumn get variance => real().nullable()();
}
