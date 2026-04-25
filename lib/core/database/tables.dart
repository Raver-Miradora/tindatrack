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
