// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reorderPointMeta = const VerificationMeta(
    'reorderPoint',
  );
  @override
  late final GeneratedColumn<double> reorderPoint = GeneratedColumn<double>(
    'reorder_point',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageCostMeta = const VerificationMeta(
    'averageCost',
  );
  @override
  late final GeneratedColumn<double> averageCost = GeneratedColumn<double>(
    'average_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _averageSellingPriceMeta =
      const VerificationMeta('averageSellingPrice');
  @override
  late final GeneratedColumn<double> averageSellingPrice =
      GeneratedColumn<double>(
        'average_selling_price',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _burnRatePerDayMeta = const VerificationMeta(
    'burnRatePerDay',
  );
  @override
  late final GeneratedColumn<double> burnRatePerDay = GeneratedColumn<double>(
    'burn_rate_per_day',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastActualQuantityMeta =
      const VerificationMeta('lastActualQuantity');
  @override
  late final GeneratedColumn<double> lastActualQuantity =
      GeneratedColumn<double>(
        'last_actual_quantity',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<double> currentStock = GeneratedColumn<double>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastCountedAtMeta = const VerificationMeta(
    'lastCountedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastCountedAt =
      GeneratedColumn<DateTime>(
        'last_counted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastBurnRateUpdateMeta =
      const VerificationMeta('lastBurnRateUpdate');
  @override
  late final GeneratedColumn<DateTime> lastBurnRateUpdate =
      GeneratedColumn<DateTime>(
        'last_burn_rate_update',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isSeededMeta = const VerificationMeta(
    'isSeeded',
  );
  @override
  late final GeneratedColumn<bool> isSeeded = GeneratedColumn<bool>(
    'is_seeded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_seeded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    barcode,
    name,
    category,
    unit,
    reorderPoint,
    averageCost,
    averageSellingPrice,
    burnRatePerDay,
    lastActualQuantity,
    currentStock,
    lastCountedAt,
    lastBurnRateUpdate,
    isActive,
    isSeeded,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('reorder_point')) {
      context.handle(
        _reorderPointMeta,
        reorderPoint.isAcceptableOrUnknown(
          data['reorder_point']!,
          _reorderPointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reorderPointMeta);
    }
    if (data.containsKey('average_cost')) {
      context.handle(
        _averageCostMeta,
        averageCost.isAcceptableOrUnknown(
          data['average_cost']!,
          _averageCostMeta,
        ),
      );
    }
    if (data.containsKey('average_selling_price')) {
      context.handle(
        _averageSellingPriceMeta,
        averageSellingPrice.isAcceptableOrUnknown(
          data['average_selling_price']!,
          _averageSellingPriceMeta,
        ),
      );
    }
    if (data.containsKey('burn_rate_per_day')) {
      context.handle(
        _burnRatePerDayMeta,
        burnRatePerDay.isAcceptableOrUnknown(
          data['burn_rate_per_day']!,
          _burnRatePerDayMeta,
        ),
      );
    }
    if (data.containsKey('last_actual_quantity')) {
      context.handle(
        _lastActualQuantityMeta,
        lastActualQuantity.isAcceptableOrUnknown(
          data['last_actual_quantity']!,
          _lastActualQuantityMeta,
        ),
      );
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    }
    if (data.containsKey('last_counted_at')) {
      context.handle(
        _lastCountedAtMeta,
        lastCountedAt.isAcceptableOrUnknown(
          data['last_counted_at']!,
          _lastCountedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_burn_rate_update')) {
      context.handle(
        _lastBurnRateUpdateMeta,
        lastBurnRateUpdate.isAcceptableOrUnknown(
          data['last_burn_rate_update']!,
          _lastBurnRateUpdateMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_seeded')) {
      context.handle(
        _isSeededMeta,
        isSeeded.isAcceptableOrUnknown(data['is_seeded']!, _isSeededMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      reorderPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reorder_point'],
      )!,
      averageCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_cost'],
      )!,
      averageSellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_selling_price'],
      ),
      burnRatePerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}burn_rate_per_day'],
      )!,
      lastActualQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_actual_quantity'],
      )!,
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_stock'],
      )!,
      lastCountedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_counted_at'],
      ),
      lastBurnRateUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_burn_rate_update'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isSeeded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_seeded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String? barcode;
  final String name;
  final String category;
  final String unit;
  final double reorderPoint;
  final double averageCost;
  final double? averageSellingPrice;
  final double burnRatePerDay;
  final double lastActualQuantity;
  final double currentStock;
  final DateTime? lastCountedAt;
  final DateTime? lastBurnRateUpdate;
  final bool isActive;
  final bool isSeeded;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product({
    required this.id,
    this.barcode,
    required this.name,
    required this.category,
    required this.unit,
    required this.reorderPoint,
    required this.averageCost,
    this.averageSellingPrice,
    required this.burnRatePerDay,
    required this.lastActualQuantity,
    required this.currentStock,
    this.lastCountedAt,
    this.lastBurnRateUpdate,
    required this.isActive,
    required this.isSeeded,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['unit'] = Variable<String>(unit);
    map['reorder_point'] = Variable<double>(reorderPoint);
    map['average_cost'] = Variable<double>(averageCost);
    if (!nullToAbsent || averageSellingPrice != null) {
      map['average_selling_price'] = Variable<double>(averageSellingPrice);
    }
    map['burn_rate_per_day'] = Variable<double>(burnRatePerDay);
    map['last_actual_quantity'] = Variable<double>(lastActualQuantity);
    map['current_stock'] = Variable<double>(currentStock);
    if (!nullToAbsent || lastCountedAt != null) {
      map['last_counted_at'] = Variable<DateTime>(lastCountedAt);
    }
    if (!nullToAbsent || lastBurnRateUpdate != null) {
      map['last_burn_rate_update'] = Variable<DateTime>(lastBurnRateUpdate);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_seeded'] = Variable<bool>(isSeeded);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      name: Value(name),
      category: Value(category),
      unit: Value(unit),
      reorderPoint: Value(reorderPoint),
      averageCost: Value(averageCost),
      averageSellingPrice: averageSellingPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(averageSellingPrice),
      burnRatePerDay: Value(burnRatePerDay),
      lastActualQuantity: Value(lastActualQuantity),
      currentStock: Value(currentStock),
      lastCountedAt: lastCountedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCountedAt),
      lastBurnRateUpdate: lastBurnRateUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBurnRateUpdate),
      isActive: Value(isActive),
      isSeeded: Value(isSeeded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      reorderPoint: serializer.fromJson<double>(json['reorderPoint']),
      averageCost: serializer.fromJson<double>(json['averageCost']),
      averageSellingPrice: serializer.fromJson<double?>(
        json['averageSellingPrice'],
      ),
      burnRatePerDay: serializer.fromJson<double>(json['burnRatePerDay']),
      lastActualQuantity: serializer.fromJson<double>(
        json['lastActualQuantity'],
      ),
      currentStock: serializer.fromJson<double>(json['currentStock']),
      lastCountedAt: serializer.fromJson<DateTime?>(json['lastCountedAt']),
      lastBurnRateUpdate: serializer.fromJson<DateTime?>(
        json['lastBurnRateUpdate'],
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isSeeded: serializer.fromJson<bool>(json['isSeeded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'barcode': serializer.toJson<String?>(barcode),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String>(unit),
      'reorderPoint': serializer.toJson<double>(reorderPoint),
      'averageCost': serializer.toJson<double>(averageCost),
      'averageSellingPrice': serializer.toJson<double?>(averageSellingPrice),
      'burnRatePerDay': serializer.toJson<double>(burnRatePerDay),
      'lastActualQuantity': serializer.toJson<double>(lastActualQuantity),
      'currentStock': serializer.toJson<double>(currentStock),
      'lastCountedAt': serializer.toJson<DateTime?>(lastCountedAt),
      'lastBurnRateUpdate': serializer.toJson<DateTime?>(lastBurnRateUpdate),
      'isActive': serializer.toJson<bool>(isActive),
      'isSeeded': serializer.toJson<bool>(isSeeded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith({
    String? id,
    Value<String?> barcode = const Value.absent(),
    String? name,
    String? category,
    String? unit,
    double? reorderPoint,
    double? averageCost,
    Value<double?> averageSellingPrice = const Value.absent(),
    double? burnRatePerDay,
    double? lastActualQuantity,
    double? currentStock,
    Value<DateTime?> lastCountedAt = const Value.absent(),
    Value<DateTime?> lastBurnRateUpdate = const Value.absent(),
    bool? isActive,
    bool? isSeeded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Product(
    id: id ?? this.id,
    barcode: barcode.present ? barcode.value : this.barcode,
    name: name ?? this.name,
    category: category ?? this.category,
    unit: unit ?? this.unit,
    reorderPoint: reorderPoint ?? this.reorderPoint,
    averageCost: averageCost ?? this.averageCost,
    averageSellingPrice: averageSellingPrice.present
        ? averageSellingPrice.value
        : this.averageSellingPrice,
    burnRatePerDay: burnRatePerDay ?? this.burnRatePerDay,
    lastActualQuantity: lastActualQuantity ?? this.lastActualQuantity,
    currentStock: currentStock ?? this.currentStock,
    lastCountedAt: lastCountedAt.present
        ? lastCountedAt.value
        : this.lastCountedAt,
    lastBurnRateUpdate: lastBurnRateUpdate.present
        ? lastBurnRateUpdate.value
        : this.lastBurnRateUpdate,
    isActive: isActive ?? this.isActive,
    isSeeded: isSeeded ?? this.isSeeded,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      reorderPoint: data.reorderPoint.present
          ? data.reorderPoint.value
          : this.reorderPoint,
      averageCost: data.averageCost.present
          ? data.averageCost.value
          : this.averageCost,
      averageSellingPrice: data.averageSellingPrice.present
          ? data.averageSellingPrice.value
          : this.averageSellingPrice,
      burnRatePerDay: data.burnRatePerDay.present
          ? data.burnRatePerDay.value
          : this.burnRatePerDay,
      lastActualQuantity: data.lastActualQuantity.present
          ? data.lastActualQuantity.value
          : this.lastActualQuantity,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      lastCountedAt: data.lastCountedAt.present
          ? data.lastCountedAt.value
          : this.lastCountedAt,
      lastBurnRateUpdate: data.lastBurnRateUpdate.present
          ? data.lastBurnRateUpdate.value
          : this.lastBurnRateUpdate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isSeeded: data.isSeeded.present ? data.isSeeded.value : this.isSeeded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('averageCost: $averageCost, ')
          ..write('averageSellingPrice: $averageSellingPrice, ')
          ..write('burnRatePerDay: $burnRatePerDay, ')
          ..write('lastActualQuantity: $lastActualQuantity, ')
          ..write('currentStock: $currentStock, ')
          ..write('lastCountedAt: $lastCountedAt, ')
          ..write('lastBurnRateUpdate: $lastBurnRateUpdate, ')
          ..write('isActive: $isActive, ')
          ..write('isSeeded: $isSeeded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    barcode,
    name,
    category,
    unit,
    reorderPoint,
    averageCost,
    averageSellingPrice,
    burnRatePerDay,
    lastActualQuantity,
    currentStock,
    lastCountedAt,
    lastBurnRateUpdate,
    isActive,
    isSeeded,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.barcode == this.barcode &&
          other.name == this.name &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.reorderPoint == this.reorderPoint &&
          other.averageCost == this.averageCost &&
          other.averageSellingPrice == this.averageSellingPrice &&
          other.burnRatePerDay == this.burnRatePerDay &&
          other.lastActualQuantity == this.lastActualQuantity &&
          other.currentStock == this.currentStock &&
          other.lastCountedAt == this.lastCountedAt &&
          other.lastBurnRateUpdate == this.lastBurnRateUpdate &&
          other.isActive == this.isActive &&
          other.isSeeded == this.isSeeded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String?> barcode;
  final Value<String> name;
  final Value<String> category;
  final Value<String> unit;
  final Value<double> reorderPoint;
  final Value<double> averageCost;
  final Value<double?> averageSellingPrice;
  final Value<double> burnRatePerDay;
  final Value<double> lastActualQuantity;
  final Value<double> currentStock;
  final Value<DateTime?> lastCountedAt;
  final Value<DateTime?> lastBurnRateUpdate;
  final Value<bool> isActive;
  final Value<bool> isSeeded;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.barcode = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    this.averageCost = const Value.absent(),
    this.averageSellingPrice = const Value.absent(),
    this.burnRatePerDay = const Value.absent(),
    this.lastActualQuantity = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.lastCountedAt = const Value.absent(),
    this.lastBurnRateUpdate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSeeded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    this.barcode = const Value.absent(),
    required String name,
    required String category,
    required String unit,
    required double reorderPoint,
    this.averageCost = const Value.absent(),
    this.averageSellingPrice = const Value.absent(),
    this.burnRatePerDay = const Value.absent(),
    this.lastActualQuantity = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.lastCountedAt = const Value.absent(),
    this.lastBurnRateUpdate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSeeded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       unit = Value(unit),
       reorderPoint = Value(reorderPoint);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? barcode,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<double>? reorderPoint,
    Expression<double>? averageCost,
    Expression<double>? averageSellingPrice,
    Expression<double>? burnRatePerDay,
    Expression<double>? lastActualQuantity,
    Expression<double>? currentStock,
    Expression<DateTime>? lastCountedAt,
    Expression<DateTime>? lastBurnRateUpdate,
    Expression<bool>? isActive,
    Expression<bool>? isSeeded,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (barcode != null) 'barcode': barcode,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (reorderPoint != null) 'reorder_point': reorderPoint,
      if (averageCost != null) 'average_cost': averageCost,
      if (averageSellingPrice != null)
        'average_selling_price': averageSellingPrice,
      if (burnRatePerDay != null) 'burn_rate_per_day': burnRatePerDay,
      if (lastActualQuantity != null)
        'last_actual_quantity': lastActualQuantity,
      if (currentStock != null) 'current_stock': currentStock,
      if (lastCountedAt != null) 'last_counted_at': lastCountedAt,
      if (lastBurnRateUpdate != null)
        'last_burn_rate_update': lastBurnRateUpdate,
      if (isActive != null) 'is_active': isActive,
      if (isSeeded != null) 'is_seeded': isSeeded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String?>? barcode,
    Value<String>? name,
    Value<String>? category,
    Value<String>? unit,
    Value<double>? reorderPoint,
    Value<double>? averageCost,
    Value<double?>? averageSellingPrice,
    Value<double>? burnRatePerDay,
    Value<double>? lastActualQuantity,
    Value<double>? currentStock,
    Value<DateTime?>? lastCountedAt,
    Value<DateTime?>? lastBurnRateUpdate,
    Value<bool>? isActive,
    Value<bool>? isSeeded,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      averageCost: averageCost ?? this.averageCost,
      averageSellingPrice: averageSellingPrice ?? this.averageSellingPrice,
      burnRatePerDay: burnRatePerDay ?? this.burnRatePerDay,
      lastActualQuantity: lastActualQuantity ?? this.lastActualQuantity,
      currentStock: currentStock ?? this.currentStock,
      lastCountedAt: lastCountedAt ?? this.lastCountedAt,
      lastBurnRateUpdate: lastBurnRateUpdate ?? this.lastBurnRateUpdate,
      isActive: isActive ?? this.isActive,
      isSeeded: isSeeded ?? this.isSeeded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (reorderPoint.present) {
      map['reorder_point'] = Variable<double>(reorderPoint.value);
    }
    if (averageCost.present) {
      map['average_cost'] = Variable<double>(averageCost.value);
    }
    if (averageSellingPrice.present) {
      map['average_selling_price'] = Variable<double>(
        averageSellingPrice.value,
      );
    }
    if (burnRatePerDay.present) {
      map['burn_rate_per_day'] = Variable<double>(burnRatePerDay.value);
    }
    if (lastActualQuantity.present) {
      map['last_actual_quantity'] = Variable<double>(lastActualQuantity.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<double>(currentStock.value);
    }
    if (lastCountedAt.present) {
      map['last_counted_at'] = Variable<DateTime>(lastCountedAt.value);
    }
    if (lastBurnRateUpdate.present) {
      map['last_burn_rate_update'] = Variable<DateTime>(
        lastBurnRateUpdate.value,
      );
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isSeeded.present) {
      map['is_seeded'] = Variable<bool>(isSeeded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('averageCost: $averageCost, ')
          ..write('averageSellingPrice: $averageSellingPrice, ')
          ..write('burnRatePerDay: $burnRatePerDay, ')
          ..write('lastActualQuantity: $lastActualQuantity, ')
          ..write('currentStock: $currentStock, ')
          ..write('lastCountedAt: $lastCountedAt, ')
          ..write('lastBurnRateUpdate: $lastBurnRateUpdate, ')
          ..write('isActive: $isActive, ')
          ..write('isSeeded: $isSeeded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockInEventsTable extends StockInEvents
    with TableInfo<$StockInEventsTable, StockInEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockInEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryDateMeta = const VerificationMeta(
    'deliveryDate',
  );
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
    'delivery_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedByMeta = const VerificationMeta(
    'loggedBy',
  );
  @override
  late final GeneratedColumn<String> loggedBy = GeneratedColumn<String>(
    'logged_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierName,
    deliveryDate,
    loggedBy,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_in_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockInEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
        _deliveryDateMeta,
        deliveryDate.isAcceptableOrUnknown(
          data['delivery_date']!,
          _deliveryDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryDateMeta);
    }
    if (data.containsKey('logged_by')) {
      context.handle(
        _loggedByMeta,
        loggedBy.isAcceptableOrUnknown(data['logged_by']!, _loggedByMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockInEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockInEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      )!,
      deliveryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivery_date'],
      )!,
      loggedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logged_by'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StockInEventsTable createAlias(String alias) {
    return $StockInEventsTable(attachedDatabase, alias);
  }
}

class StockInEvent extends DataClass implements Insertable<StockInEvent> {
  final String id;
  final String supplierName;
  final DateTime deliveryDate;
  final String? loggedBy;
  final String? notes;
  final DateTime createdAt;
  const StockInEvent({
    required this.id,
    required this.supplierName,
    required this.deliveryDate,
    this.loggedBy,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['supplier_name'] = Variable<String>(supplierName);
    map['delivery_date'] = Variable<DateTime>(deliveryDate);
    if (!nullToAbsent || loggedBy != null) {
      map['logged_by'] = Variable<String>(loggedBy);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockInEventsCompanion toCompanion(bool nullToAbsent) {
    return StockInEventsCompanion(
      id: Value(id),
      supplierName: Value(supplierName),
      deliveryDate: Value(deliveryDate),
      loggedBy: loggedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(loggedBy),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory StockInEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockInEvent(
      id: serializer.fromJson<String>(json['id']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      deliveryDate: serializer.fromJson<DateTime>(json['deliveryDate']),
      loggedBy: serializer.fromJson<String?>(json['loggedBy']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'supplierName': serializer.toJson<String>(supplierName),
      'deliveryDate': serializer.toJson<DateTime>(deliveryDate),
      'loggedBy': serializer.toJson<String?>(loggedBy),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockInEvent copyWith({
    String? id,
    String? supplierName,
    DateTime? deliveryDate,
    Value<String?> loggedBy = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => StockInEvent(
    id: id ?? this.id,
    supplierName: supplierName ?? this.supplierName,
    deliveryDate: deliveryDate ?? this.deliveryDate,
    loggedBy: loggedBy.present ? loggedBy.value : this.loggedBy,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  StockInEvent copyWithCompanion(StockInEventsCompanion data) {
    return StockInEvent(
      id: data.id.present ? data.id.value : this.id,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      loggedBy: data.loggedBy.present ? data.loggedBy.value : this.loggedBy,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockInEvent(')
          ..write('id: $id, ')
          ..write('supplierName: $supplierName, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('loggedBy: $loggedBy, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, supplierName, deliveryDate, loggedBy, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockInEvent &&
          other.id == this.id &&
          other.supplierName == this.supplierName &&
          other.deliveryDate == this.deliveryDate &&
          other.loggedBy == this.loggedBy &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class StockInEventsCompanion extends UpdateCompanion<StockInEvent> {
  final Value<String> id;
  final Value<String> supplierName;
  final Value<DateTime> deliveryDate;
  final Value<String?> loggedBy;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StockInEventsCompanion({
    this.id = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.loggedBy = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockInEventsCompanion.insert({
    required String id,
    required String supplierName,
    required DateTime deliveryDate,
    this.loggedBy = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       supplierName = Value(supplierName),
       deliveryDate = Value(deliveryDate);
  static Insertable<StockInEvent> custom({
    Expression<String>? id,
    Expression<String>? supplierName,
    Expression<DateTime>? deliveryDate,
    Expression<String>? loggedBy,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierName != null) 'supplier_name': supplierName,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (loggedBy != null) 'logged_by': loggedBy,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockInEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? supplierName,
    Value<DateTime>? deliveryDate,
    Value<String?>? loggedBy,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StockInEventsCompanion(
      id: id ?? this.id,
      supplierName: supplierName ?? this.supplierName,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      loggedBy: loggedBy ?? this.loggedBy,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (loggedBy.present) {
      map['logged_by'] = Variable<String>(loggedBy.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockInEventsCompanion(')
          ..write('id: $id, ')
          ..write('supplierName: $supplierName, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('loggedBy: $loggedBy, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockInItemsTable extends StockInItems
    with TableInfo<$StockInItemsTable, StockInItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockInItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockInEventIdMeta = const VerificationMeta(
    'stockInEventId',
  );
  @override
  late final GeneratedColumn<String> stockInEventId = GeneratedColumn<String>(
    'stock_in_event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stock_in_events (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stockInEventId,
    productId,
    quantity,
    unitCost,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_in_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockInItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('stock_in_event_id')) {
      context.handle(
        _stockInEventIdMeta,
        stockInEventId.isAcceptableOrUnknown(
          data['stock_in_event_id']!,
          _stockInEventIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockInEventIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockInItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockInItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      stockInEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stock_in_event_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
    );
  }

  @override
  $StockInItemsTable createAlias(String alias) {
    return $StockInItemsTable(attachedDatabase, alias);
  }
}

class StockInItem extends DataClass implements Insertable<StockInItem> {
  final String id;
  final String stockInEventId;
  final String productId;
  final double quantity;
  final double unitCost;
  const StockInItem({
    required this.id,
    required this.stockInEventId,
    required this.productId,
    required this.quantity,
    required this.unitCost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['stock_in_event_id'] = Variable<String>(stockInEventId);
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_cost'] = Variable<double>(unitCost);
    return map;
  }

  StockInItemsCompanion toCompanion(bool nullToAbsent) {
    return StockInItemsCompanion(
      id: Value(id),
      stockInEventId: Value(stockInEventId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitCost: Value(unitCost),
    );
  }

  factory StockInItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockInItem(
      id: serializer.fromJson<String>(json['id']),
      stockInEventId: serializer.fromJson<String>(json['stockInEventId']),
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'stockInEventId': serializer.toJson<String>(stockInEventId),
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'unitCost': serializer.toJson<double>(unitCost),
    };
  }

  StockInItem copyWith({
    String? id,
    String? stockInEventId,
    String? productId,
    double? quantity,
    double? unitCost,
  }) => StockInItem(
    id: id ?? this.id,
    stockInEventId: stockInEventId ?? this.stockInEventId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    unitCost: unitCost ?? this.unitCost,
  );
  StockInItem copyWithCompanion(StockInItemsCompanion data) {
    return StockInItem(
      id: data.id.present ? data.id.value : this.id,
      stockInEventId: data.stockInEventId.present
          ? data.stockInEventId.value
          : this.stockInEventId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockInItem(')
          ..write('id: $id, ')
          ..write('stockInEventId: $stockInEventId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCost: $unitCost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, stockInEventId, productId, quantity, unitCost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockInItem &&
          other.id == this.id &&
          other.stockInEventId == this.stockInEventId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitCost == this.unitCost);
}

class StockInItemsCompanion extends UpdateCompanion<StockInItem> {
  final Value<String> id;
  final Value<String> stockInEventId;
  final Value<String> productId;
  final Value<double> quantity;
  final Value<double> unitCost;
  final Value<int> rowid;
  const StockInItemsCompanion({
    this.id = const Value.absent(),
    this.stockInEventId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockInItemsCompanion.insert({
    required String id,
    required String stockInEventId,
    required String productId,
    required double quantity,
    required double unitCost,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       stockInEventId = Value(stockInEventId),
       productId = Value(productId),
       quantity = Value(quantity),
       unitCost = Value(unitCost);
  static Insertable<StockInItem> custom({
    Expression<String>? id,
    Expression<String>? stockInEventId,
    Expression<String>? productId,
    Expression<double>? quantity,
    Expression<double>? unitCost,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stockInEventId != null) 'stock_in_event_id': stockInEventId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitCost != null) 'unit_cost': unitCost,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockInItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? stockInEventId,
    Value<String>? productId,
    Value<double>? quantity,
    Value<double>? unitCost,
    Value<int>? rowid,
  }) {
    return StockInItemsCompanion(
      id: id ?? this.id,
      stockInEventId: stockInEventId ?? this.stockInEventId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitCost: unitCost ?? this.unitCost,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (stockInEventId.present) {
      map['stock_in_event_id'] = Variable<String>(stockInEventId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockInItemsCompanion(')
          ..write('id: $id, ')
          ..write('stockInEventId: $stockInEventId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCost: $unitCost, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CountSessionsTable extends CountSessions
    with TableInfo<$CountSessionsTable, CountSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countTypeMeta = const VerificationMeta(
    'countType',
  );
  @override
  late final GeneratedColumn<String> countType = GeneratedColumn<String>(
    'count_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countedByMeta = const VerificationMeta(
    'countedBy',
  );
  @override
  late final GeneratedColumn<String> countedBy = GeneratedColumn<String>(
    'counted_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    countType,
    countedBy,
    startedAt,
    completedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'count_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CountSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('count_type')) {
      context.handle(
        _countTypeMeta,
        countType.isAcceptableOrUnknown(data['count_type']!, _countTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_countTypeMeta);
    }
    if (data.containsKey('counted_by')) {
      context.handle(
        _countedByMeta,
        countedBy.isAcceptableOrUnknown(data['counted_by']!, _countedByMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CountSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CountSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      countType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}count_type'],
      )!,
      countedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counted_by'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $CountSessionsTable createAlias(String alias) {
    return $CountSessionsTable(attachedDatabase, alias);
  }
}

class CountSession extends DataClass implements Insertable<CountSession> {
  final String id;
  final String countType;
  final String? countedBy;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String? notes;
  const CountSession({
    required this.id,
    required this.countType,
    this.countedBy,
    required this.startedAt,
    this.completedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['count_type'] = Variable<String>(countType);
    if (!nullToAbsent || countedBy != null) {
      map['counted_by'] = Variable<String>(countedBy);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CountSessionsCompanion toCompanion(bool nullToAbsent) {
    return CountSessionsCompanion(
      id: Value(id),
      countType: Value(countType),
      countedBy: countedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(countedBy),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory CountSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountSession(
      id: serializer.fromJson<String>(json['id']),
      countType: serializer.fromJson<String>(json['countType']),
      countedBy: serializer.fromJson<String?>(json['countedBy']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'countType': serializer.toJson<String>(countType),
      'countedBy': serializer.toJson<String?>(countedBy),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CountSession copyWith({
    String? id,
    String? countType,
    Value<String?> countedBy = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => CountSession(
    id: id ?? this.id,
    countType: countType ?? this.countType,
    countedBy: countedBy.present ? countedBy.value : this.countedBy,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  CountSession copyWithCompanion(CountSessionsCompanion data) {
    return CountSession(
      id: data.id.present ? data.id.value : this.id,
      countType: data.countType.present ? data.countType.value : this.countType,
      countedBy: data.countedBy.present ? data.countedBy.value : this.countedBy,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CountSession(')
          ..write('id: $id, ')
          ..write('countType: $countType, ')
          ..write('countedBy: $countedBy, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, countType, countedBy, startedAt, completedAt, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountSession &&
          other.id == this.id &&
          other.countType == this.countType &&
          other.countedBy == this.countedBy &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.notes == this.notes);
}

class CountSessionsCompanion extends UpdateCompanion<CountSession> {
  final Value<String> id;
  final Value<String> countType;
  final Value<String?> countedBy;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const CountSessionsCompanion({
    this.id = const Value.absent(),
    this.countType = const Value.absent(),
    this.countedBy = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CountSessionsCompanion.insert({
    required String id,
    required String countType,
    this.countedBy = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       countType = Value(countType);
  static Insertable<CountSession> custom({
    Expression<String>? id,
    Expression<String>? countType,
    Expression<String>? countedBy,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (countType != null) 'count_type': countType,
      if (countedBy != null) 'counted_by': countedBy,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CountSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? countType,
    Value<String?>? countedBy,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return CountSessionsCompanion(
      id: id ?? this.id,
      countType: countType ?? this.countType,
      countedBy: countedBy ?? this.countedBy,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (countType.present) {
      map['count_type'] = Variable<String>(countType.value);
    }
    if (countedBy.present) {
      map['counted_by'] = Variable<String>(countedBy.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountSessionsCompanion(')
          ..write('id: $id, ')
          ..write('countType: $countType, ')
          ..write('countedBy: $countedBy, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CountItemsTable extends CountItems
    with TableInfo<$CountItemsTable, CountItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countSessionIdMeta = const VerificationMeta(
    'countSessionId',
  );
  @override
  late final GeneratedColumn<String> countSessionId = GeneratedColumn<String>(
    'count_session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES count_sessions (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _expectedQuantityMeta = const VerificationMeta(
    'expectedQuantity',
  );
  @override
  late final GeneratedColumn<double> expectedQuantity = GeneratedColumn<double>(
    'expected_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualQuantityMeta = const VerificationMeta(
    'actualQuantity',
  );
  @override
  late final GeneratedColumn<double> actualQuantity = GeneratedColumn<double>(
    'actual_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _varianceMeta = const VerificationMeta(
    'variance',
  );
  @override
  late final GeneratedColumn<double> variance = GeneratedColumn<double>(
    'variance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _varianceReasonMeta = const VerificationMeta(
    'varianceReason',
  );
  @override
  late final GeneratedColumn<String> varianceReason = GeneratedColumn<String>(
    'variance_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countedAtMeta = const VerificationMeta(
    'countedAt',
  );
  @override
  late final GeneratedColumn<DateTime> countedAt = GeneratedColumn<DateTime>(
    'counted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    countSessionId,
    productId,
    expectedQuantity,
    actualQuantity,
    variance,
    varianceReason,
    notes,
    countedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'count_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CountItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('count_session_id')) {
      context.handle(
        _countSessionIdMeta,
        countSessionId.isAcceptableOrUnknown(
          data['count_session_id']!,
          _countSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countSessionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('expected_quantity')) {
      context.handle(
        _expectedQuantityMeta,
        expectedQuantity.isAcceptableOrUnknown(
          data['expected_quantity']!,
          _expectedQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedQuantityMeta);
    }
    if (data.containsKey('actual_quantity')) {
      context.handle(
        _actualQuantityMeta,
        actualQuantity.isAcceptableOrUnknown(
          data['actual_quantity']!,
          _actualQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualQuantityMeta);
    }
    if (data.containsKey('variance')) {
      context.handle(
        _varianceMeta,
        variance.isAcceptableOrUnknown(data['variance']!, _varianceMeta),
      );
    } else if (isInserting) {
      context.missing(_varianceMeta);
    }
    if (data.containsKey('variance_reason')) {
      context.handle(
        _varianceReasonMeta,
        varianceReason.isAcceptableOrUnknown(
          data['variance_reason']!,
          _varianceReasonMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('counted_at')) {
      context.handle(
        _countedAtMeta,
        countedAt.isAcceptableOrUnknown(data['counted_at']!, _countedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CountItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CountItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      countSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}count_session_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      expectedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_quantity'],
      )!,
      actualQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_quantity'],
      )!,
      variance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}variance'],
      )!,
      varianceReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variance_reason'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      countedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}counted_at'],
      )!,
    );
  }

  @override
  $CountItemsTable createAlias(String alias) {
    return $CountItemsTable(attachedDatabase, alias);
  }
}

class CountItem extends DataClass implements Insertable<CountItem> {
  final String id;
  final String countSessionId;
  final String productId;
  final double expectedQuantity;
  final double actualQuantity;
  final double variance;
  final String? varianceReason;
  final String? notes;
  final DateTime countedAt;
  const CountItem({
    required this.id,
    required this.countSessionId,
    required this.productId,
    required this.expectedQuantity,
    required this.actualQuantity,
    required this.variance,
    this.varianceReason,
    this.notes,
    required this.countedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['count_session_id'] = Variable<String>(countSessionId);
    map['product_id'] = Variable<String>(productId);
    map['expected_quantity'] = Variable<double>(expectedQuantity);
    map['actual_quantity'] = Variable<double>(actualQuantity);
    map['variance'] = Variable<double>(variance);
    if (!nullToAbsent || varianceReason != null) {
      map['variance_reason'] = Variable<String>(varianceReason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['counted_at'] = Variable<DateTime>(countedAt);
    return map;
  }

  CountItemsCompanion toCompanion(bool nullToAbsent) {
    return CountItemsCompanion(
      id: Value(id),
      countSessionId: Value(countSessionId),
      productId: Value(productId),
      expectedQuantity: Value(expectedQuantity),
      actualQuantity: Value(actualQuantity),
      variance: Value(variance),
      varianceReason: varianceReason == null && nullToAbsent
          ? const Value.absent()
          : Value(varianceReason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      countedAt: Value(countedAt),
    );
  }

  factory CountItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountItem(
      id: serializer.fromJson<String>(json['id']),
      countSessionId: serializer.fromJson<String>(json['countSessionId']),
      productId: serializer.fromJson<String>(json['productId']),
      expectedQuantity: serializer.fromJson<double>(json['expectedQuantity']),
      actualQuantity: serializer.fromJson<double>(json['actualQuantity']),
      variance: serializer.fromJson<double>(json['variance']),
      varianceReason: serializer.fromJson<String?>(json['varianceReason']),
      notes: serializer.fromJson<String?>(json['notes']),
      countedAt: serializer.fromJson<DateTime>(json['countedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'countSessionId': serializer.toJson<String>(countSessionId),
      'productId': serializer.toJson<String>(productId),
      'expectedQuantity': serializer.toJson<double>(expectedQuantity),
      'actualQuantity': serializer.toJson<double>(actualQuantity),
      'variance': serializer.toJson<double>(variance),
      'varianceReason': serializer.toJson<String?>(varianceReason),
      'notes': serializer.toJson<String?>(notes),
      'countedAt': serializer.toJson<DateTime>(countedAt),
    };
  }

  CountItem copyWith({
    String? id,
    String? countSessionId,
    String? productId,
    double? expectedQuantity,
    double? actualQuantity,
    double? variance,
    Value<String?> varianceReason = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? countedAt,
  }) => CountItem(
    id: id ?? this.id,
    countSessionId: countSessionId ?? this.countSessionId,
    productId: productId ?? this.productId,
    expectedQuantity: expectedQuantity ?? this.expectedQuantity,
    actualQuantity: actualQuantity ?? this.actualQuantity,
    variance: variance ?? this.variance,
    varianceReason: varianceReason.present
        ? varianceReason.value
        : this.varianceReason,
    notes: notes.present ? notes.value : this.notes,
    countedAt: countedAt ?? this.countedAt,
  );
  CountItem copyWithCompanion(CountItemsCompanion data) {
    return CountItem(
      id: data.id.present ? data.id.value : this.id,
      countSessionId: data.countSessionId.present
          ? data.countSessionId.value
          : this.countSessionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      expectedQuantity: data.expectedQuantity.present
          ? data.expectedQuantity.value
          : this.expectedQuantity,
      actualQuantity: data.actualQuantity.present
          ? data.actualQuantity.value
          : this.actualQuantity,
      variance: data.variance.present ? data.variance.value : this.variance,
      varianceReason: data.varianceReason.present
          ? data.varianceReason.value
          : this.varianceReason,
      notes: data.notes.present ? data.notes.value : this.notes,
      countedAt: data.countedAt.present ? data.countedAt.value : this.countedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CountItem(')
          ..write('id: $id, ')
          ..write('countSessionId: $countSessionId, ')
          ..write('productId: $productId, ')
          ..write('expectedQuantity: $expectedQuantity, ')
          ..write('actualQuantity: $actualQuantity, ')
          ..write('variance: $variance, ')
          ..write('varianceReason: $varianceReason, ')
          ..write('notes: $notes, ')
          ..write('countedAt: $countedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    countSessionId,
    productId,
    expectedQuantity,
    actualQuantity,
    variance,
    varianceReason,
    notes,
    countedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountItem &&
          other.id == this.id &&
          other.countSessionId == this.countSessionId &&
          other.productId == this.productId &&
          other.expectedQuantity == this.expectedQuantity &&
          other.actualQuantity == this.actualQuantity &&
          other.variance == this.variance &&
          other.varianceReason == this.varianceReason &&
          other.notes == this.notes &&
          other.countedAt == this.countedAt);
}

class CountItemsCompanion extends UpdateCompanion<CountItem> {
  final Value<String> id;
  final Value<String> countSessionId;
  final Value<String> productId;
  final Value<double> expectedQuantity;
  final Value<double> actualQuantity;
  final Value<double> variance;
  final Value<String?> varianceReason;
  final Value<String?> notes;
  final Value<DateTime> countedAt;
  final Value<int> rowid;
  const CountItemsCompanion({
    this.id = const Value.absent(),
    this.countSessionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.expectedQuantity = const Value.absent(),
    this.actualQuantity = const Value.absent(),
    this.variance = const Value.absent(),
    this.varianceReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.countedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CountItemsCompanion.insert({
    required String id,
    required String countSessionId,
    required String productId,
    required double expectedQuantity,
    required double actualQuantity,
    required double variance,
    this.varianceReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.countedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       countSessionId = Value(countSessionId),
       productId = Value(productId),
       expectedQuantity = Value(expectedQuantity),
       actualQuantity = Value(actualQuantity),
       variance = Value(variance);
  static Insertable<CountItem> custom({
    Expression<String>? id,
    Expression<String>? countSessionId,
    Expression<String>? productId,
    Expression<double>? expectedQuantity,
    Expression<double>? actualQuantity,
    Expression<double>? variance,
    Expression<String>? varianceReason,
    Expression<String>? notes,
    Expression<DateTime>? countedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (countSessionId != null) 'count_session_id': countSessionId,
      if (productId != null) 'product_id': productId,
      if (expectedQuantity != null) 'expected_quantity': expectedQuantity,
      if (actualQuantity != null) 'actual_quantity': actualQuantity,
      if (variance != null) 'variance': variance,
      if (varianceReason != null) 'variance_reason': varianceReason,
      if (notes != null) 'notes': notes,
      if (countedAt != null) 'counted_at': countedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CountItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? countSessionId,
    Value<String>? productId,
    Value<double>? expectedQuantity,
    Value<double>? actualQuantity,
    Value<double>? variance,
    Value<String?>? varianceReason,
    Value<String?>? notes,
    Value<DateTime>? countedAt,
    Value<int>? rowid,
  }) {
    return CountItemsCompanion(
      id: id ?? this.id,
      countSessionId: countSessionId ?? this.countSessionId,
      productId: productId ?? this.productId,
      expectedQuantity: expectedQuantity ?? this.expectedQuantity,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      variance: variance ?? this.variance,
      varianceReason: varianceReason ?? this.varianceReason,
      notes: notes ?? this.notes,
      countedAt: countedAt ?? this.countedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (countSessionId.present) {
      map['count_session_id'] = Variable<String>(countSessionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (expectedQuantity.present) {
      map['expected_quantity'] = Variable<double>(expectedQuantity.value);
    }
    if (actualQuantity.present) {
      map['actual_quantity'] = Variable<double>(actualQuantity.value);
    }
    if (variance.present) {
      map['variance'] = Variable<double>(variance.value);
    }
    if (varianceReason.present) {
      map['variance_reason'] = Variable<String>(varianceReason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (countedAt.present) {
      map['counted_at'] = Variable<DateTime>(countedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountItemsCompanion(')
          ..write('id: $id, ')
          ..write('countSessionId: $countSessionId, ')
          ..write('productId: $productId, ')
          ..write('expectedQuantity: $expectedQuantity, ')
          ..write('actualQuantity: $actualQuantity, ')
          ..write('variance: $variance, ')
          ..write('varianceReason: $varianceReason, ')
          ..write('notes: $notes, ')
          ..write('countedAt: $countedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlertsTable extends Alerts with TableInfo<$AlertsTable, Alert> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _alertTypeMeta = const VerificationMeta(
    'alertType',
  );
  @override
  late final GeneratedColumn<String> alertType = GeneratedColumn<String>(
    'alert_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _triggeredAtMeta = const VerificationMeta(
    'triggeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> triggeredAt = GeneratedColumn<DateTime>(
    'triggered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _acknowledgedAtMeta = const VerificationMeta(
    'acknowledgedAt',
  );
  @override
  late final GeneratedColumn<DateTime> acknowledgedAt =
      GeneratedColumn<DateTime>(
        'acknowledged_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _snoozeUntilMeta = const VerificationMeta(
    'snoozeUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozeUntil = GeneratedColumn<DateTime>(
    'snooze_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    alertType,
    severity,
    message,
    status,
    triggeredAt,
    acknowledgedAt,
    resolvedAt,
    snoozeUntil,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alerts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Alert> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('alert_type')) {
      context.handle(
        _alertTypeMeta,
        alertType.isAcceptableOrUnknown(data['alert_type']!, _alertTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_alertTypeMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('triggered_at')) {
      context.handle(
        _triggeredAtMeta,
        triggeredAt.isAcceptableOrUnknown(
          data['triggered_at']!,
          _triggeredAtMeta,
        ),
      );
    }
    if (data.containsKey('acknowledged_at')) {
      context.handle(
        _acknowledgedAtMeta,
        acknowledgedAt.isAcceptableOrUnknown(
          data['acknowledged_at']!,
          _acknowledgedAtMeta,
        ),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('snooze_until')) {
      context.handle(
        _snoozeUntilMeta,
        snoozeUntil.isAcceptableOrUnknown(
          data['snooze_until']!,
          _snoozeUntilMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alert map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alert(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      alertType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_type'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      triggeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}triggered_at'],
      )!,
      acknowledgedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acknowledged_at'],
      ),
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      snoozeUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snooze_until'],
      ),
    );
  }

  @override
  $AlertsTable createAlias(String alias) {
    return $AlertsTable(attachedDatabase, alias);
  }
}

class Alert extends DataClass implements Insertable<Alert> {
  final String id;
  final String? productId;
  final String alertType;
  final String severity;
  final String message;
  final String status;
  final DateTime triggeredAt;
  final DateTime? acknowledgedAt;
  final DateTime? resolvedAt;
  final DateTime? snoozeUntil;
  const Alert({
    required this.id,
    this.productId,
    required this.alertType,
    required this.severity,
    required this.message,
    required this.status,
    required this.triggeredAt,
    this.acknowledgedAt,
    this.resolvedAt,
    this.snoozeUntil,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['alert_type'] = Variable<String>(alertType);
    map['severity'] = Variable<String>(severity);
    map['message'] = Variable<String>(message);
    map['status'] = Variable<String>(status);
    map['triggered_at'] = Variable<DateTime>(triggeredAt);
    if (!nullToAbsent || acknowledgedAt != null) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || snoozeUntil != null) {
      map['snooze_until'] = Variable<DateTime>(snoozeUntil);
    }
    return map;
  }

  AlertsCompanion toCompanion(bool nullToAbsent) {
    return AlertsCompanion(
      id: Value(id),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      alertType: Value(alertType),
      severity: Value(severity),
      message: Value(message),
      status: Value(status),
      triggeredAt: Value(triggeredAt),
      acknowledgedAt: acknowledgedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acknowledgedAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      snoozeUntil: snoozeUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozeUntil),
    );
  }

  factory Alert.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alert(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String?>(json['productId']),
      alertType: serializer.fromJson<String>(json['alertType']),
      severity: serializer.fromJson<String>(json['severity']),
      message: serializer.fromJson<String>(json['message']),
      status: serializer.fromJson<String>(json['status']),
      triggeredAt: serializer.fromJson<DateTime>(json['triggeredAt']),
      acknowledgedAt: serializer.fromJson<DateTime?>(json['acknowledgedAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      snoozeUntil: serializer.fromJson<DateTime?>(json['snoozeUntil']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String?>(productId),
      'alertType': serializer.toJson<String>(alertType),
      'severity': serializer.toJson<String>(severity),
      'message': serializer.toJson<String>(message),
      'status': serializer.toJson<String>(status),
      'triggeredAt': serializer.toJson<DateTime>(triggeredAt),
      'acknowledgedAt': serializer.toJson<DateTime?>(acknowledgedAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'snoozeUntil': serializer.toJson<DateTime?>(snoozeUntil),
    };
  }

  Alert copyWith({
    String? id,
    Value<String?> productId = const Value.absent(),
    String? alertType,
    String? severity,
    String? message,
    String? status,
    DateTime? triggeredAt,
    Value<DateTime?> acknowledgedAt = const Value.absent(),
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<DateTime?> snoozeUntil = const Value.absent(),
  }) => Alert(
    id: id ?? this.id,
    productId: productId.present ? productId.value : this.productId,
    alertType: alertType ?? this.alertType,
    severity: severity ?? this.severity,
    message: message ?? this.message,
    status: status ?? this.status,
    triggeredAt: triggeredAt ?? this.triggeredAt,
    acknowledgedAt: acknowledgedAt.present
        ? acknowledgedAt.value
        : this.acknowledgedAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    snoozeUntil: snoozeUntil.present ? snoozeUntil.value : this.snoozeUntil,
  );
  Alert copyWithCompanion(AlertsCompanion data) {
    return Alert(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      alertType: data.alertType.present ? data.alertType.value : this.alertType,
      severity: data.severity.present ? data.severity.value : this.severity,
      message: data.message.present ? data.message.value : this.message,
      status: data.status.present ? data.status.value : this.status,
      triggeredAt: data.triggeredAt.present
          ? data.triggeredAt.value
          : this.triggeredAt,
      acknowledgedAt: data.acknowledgedAt.present
          ? data.acknowledgedAt.value
          : this.acknowledgedAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      snoozeUntil: data.snoozeUntil.present
          ? data.snoozeUntil.value
          : this.snoozeUntil,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alert(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('alertType: $alertType, ')
          ..write('severity: $severity, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('snoozeUntil: $snoozeUntil')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    alertType,
    severity,
    message,
    status,
    triggeredAt,
    acknowledgedAt,
    resolvedAt,
    snoozeUntil,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alert &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.alertType == this.alertType &&
          other.severity == this.severity &&
          other.message == this.message &&
          other.status == this.status &&
          other.triggeredAt == this.triggeredAt &&
          other.acknowledgedAt == this.acknowledgedAt &&
          other.resolvedAt == this.resolvedAt &&
          other.snoozeUntil == this.snoozeUntil);
}

class AlertsCompanion extends UpdateCompanion<Alert> {
  final Value<String> id;
  final Value<String?> productId;
  final Value<String> alertType;
  final Value<String> severity;
  final Value<String> message;
  final Value<String> status;
  final Value<DateTime> triggeredAt;
  final Value<DateTime?> acknowledgedAt;
  final Value<DateTime?> resolvedAt;
  final Value<DateTime?> snoozeUntil;
  final Value<int> rowid;
  const AlertsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.alertType = const Value.absent(),
    this.severity = const Value.absent(),
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.triggeredAt = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.snoozeUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlertsCompanion.insert({
    required String id,
    this.productId = const Value.absent(),
    required String alertType,
    required String severity,
    required String message,
    this.status = const Value.absent(),
    this.triggeredAt = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.snoozeUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       alertType = Value(alertType),
       severity = Value(severity),
       message = Value(message);
  static Insertable<Alert> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? alertType,
    Expression<String>? severity,
    Expression<String>? message,
    Expression<String>? status,
    Expression<DateTime>? triggeredAt,
    Expression<DateTime>? acknowledgedAt,
    Expression<DateTime>? resolvedAt,
    Expression<DateTime>? snoozeUntil,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (alertType != null) 'alert_type': alertType,
      if (severity != null) 'severity': severity,
      if (message != null) 'message': message,
      if (status != null) 'status': status,
      if (triggeredAt != null) 'triggered_at': triggeredAt,
      if (acknowledgedAt != null) 'acknowledged_at': acknowledgedAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (snoozeUntil != null) 'snooze_until': snoozeUntil,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlertsCompanion copyWith({
    Value<String>? id,
    Value<String?>? productId,
    Value<String>? alertType,
    Value<String>? severity,
    Value<String>? message,
    Value<String>? status,
    Value<DateTime>? triggeredAt,
    Value<DateTime?>? acknowledgedAt,
    Value<DateTime?>? resolvedAt,
    Value<DateTime?>? snoozeUntil,
    Value<int>? rowid,
  }) {
    return AlertsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      alertType: alertType ?? this.alertType,
      severity: severity ?? this.severity,
      message: message ?? this.message,
      status: status ?? this.status,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      snoozeUntil: snoozeUntil ?? this.snoozeUntil,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (alertType.present) {
      map['alert_type'] = Variable<String>(alertType.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (triggeredAt.present) {
      map['triggered_at'] = Variable<DateTime>(triggeredAt.value);
    }
    if (acknowledgedAt.present) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (snoozeUntil.present) {
      map['snooze_until'] = Variable<DateTime>(snoozeUntil.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlertsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('alertType: $alertType, ')
          ..write('severity: $severity, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('snoozeUntil: $snoozeUntil, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
    'pin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    role,
    pin,
    email,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('pin')) {
      context.handle(
        _pinMeta,
        pin.isAcceptableOrUnknown(data['pin']!, _pinMeta),
      );
    } else if (isInserting) {
      context.missing(_pinMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String displayName;
  final String role;
  final String pin;
  final String? email;
  final bool isActive;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.displayName,
    required this.role,
    required this.pin,
    this.email,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['role'] = Variable<String>(role);
    map['pin'] = Variable<String>(pin);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      displayName: Value(displayName),
      role: Value(role),
      pin: Value(pin),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      role: serializer.fromJson<String>(json['role']),
      pin: serializer.fromJson<String>(json['pin']),
      email: serializer.fromJson<String?>(json['email']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'role': serializer.toJson<String>(role),
      'pin': serializer.toJson<String>(pin),
      'email': serializer.toJson<String?>(email),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    String? id,
    String? displayName,
    String? role,
    String? pin,
    Value<String?> email = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    role: role ?? this.role,
    pin: pin ?? this.pin,
    email: email.present ? email.value : this.email,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      role: data.role.present ? data.role.value : this.role,
      pin: data.pin.present ? data.pin.value : this.pin,
      email: data.email.present ? data.email.value : this.email,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('pin: $pin, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, displayName, role, pin, email, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.role == this.role &&
          other.pin == this.pin &&
          other.email == this.email &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String> role;
  final Value<String> pin;
  final Value<String?> email;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.role = const Value.absent(),
    this.pin = const Value.absent(),
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String displayName,
    required String role,
    required String pin,
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       role = Value(role),
       pin = Value(pin);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? role,
    Expression<String>? pin,
    Expression<String>? email,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (role != null) 'role': role,
      if (pin != null) 'pin': pin,
      if (email != null) 'email': email,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String>? role,
    Value<String>? pin,
    Value<String?>? email,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      pin: pin ?? this.pin,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pin.present) {
      map['pin'] = Variable<String>(pin.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('pin: $pin, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogTable extends AuditLog
    with TableInfo<$AuditLogTable, AuditLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _performedByMeta = const VerificationMeta(
    'performedBy',
  );
  @override
  late final GeneratedColumn<String> performedBy = GeneratedColumn<String>(
    'performed_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionTypeMeta = const VerificationMeta(
    'actionType',
  );
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTypeMeta = const VerificationMeta(
    'targetType',
  );
  @override
  late final GeneratedColumn<String> targetType = GeneratedColumn<String>(
    'target_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beforeSnapshotMeta = const VerificationMeta(
    'beforeSnapshot',
  );
  @override
  late final GeneratedColumn<String> beforeSnapshot = GeneratedColumn<String>(
    'before_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _afterSnapshotMeta = const VerificationMeta(
    'afterSnapshot',
  );
  @override
  late final GeneratedColumn<String> afterSnapshot = GeneratedColumn<String>(
    'after_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    performedBy,
    actionType,
    targetType,
    targetId,
    beforeSnapshot,
    afterSnapshot,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('performed_by')) {
      context.handle(
        _performedByMeta,
        performedBy.isAcceptableOrUnknown(
          data['performed_by']!,
          _performedByMeta,
        ),
      );
    }
    if (data.containsKey('action_type')) {
      context.handle(
        _actionTypeMeta,
        actionType.isAcceptableOrUnknown(data['action_type']!, _actionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('target_type')) {
      context.handle(
        _targetTypeMeta,
        targetType.isAcceptableOrUnknown(data['target_type']!, _targetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTypeMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('before_snapshot')) {
      context.handle(
        _beforeSnapshotMeta,
        beforeSnapshot.isAcceptableOrUnknown(
          data['before_snapshot']!,
          _beforeSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('after_snapshot')) {
      context.handle(
        _afterSnapshotMeta,
        afterSnapshot.isAcceptableOrUnknown(
          data['after_snapshot']!,
          _afterSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      performedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}performed_by'],
      ),
      actionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_type'],
      )!,
      targetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_type'],
      )!,
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      )!,
      beforeSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}before_snapshot'],
      ),
      afterSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}after_snapshot'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $AuditLogTable createAlias(String alias) {
    return $AuditLogTable(attachedDatabase, alias);
  }
}

class AuditLogData extends DataClass implements Insertable<AuditLogData> {
  final String id;
  final String? performedBy;
  final String actionType;
  final String targetType;
  final String targetId;
  final String? beforeSnapshot;
  final String? afterSnapshot;
  final DateTime timestamp;
  const AuditLogData({
    required this.id,
    this.performedBy,
    required this.actionType,
    required this.targetType,
    required this.targetId,
    this.beforeSnapshot,
    this.afterSnapshot,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || performedBy != null) {
      map['performed_by'] = Variable<String>(performedBy);
    }
    map['action_type'] = Variable<String>(actionType);
    map['target_type'] = Variable<String>(targetType);
    map['target_id'] = Variable<String>(targetId);
    if (!nullToAbsent || beforeSnapshot != null) {
      map['before_snapshot'] = Variable<String>(beforeSnapshot);
    }
    if (!nullToAbsent || afterSnapshot != null) {
      map['after_snapshot'] = Variable<String>(afterSnapshot);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  AuditLogCompanion toCompanion(bool nullToAbsent) {
    return AuditLogCompanion(
      id: Value(id),
      performedBy: performedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(performedBy),
      actionType: Value(actionType),
      targetType: Value(targetType),
      targetId: Value(targetId),
      beforeSnapshot: beforeSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(beforeSnapshot),
      afterSnapshot: afterSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSnapshot),
      timestamp: Value(timestamp),
    );
  }

  factory AuditLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogData(
      id: serializer.fromJson<String>(json['id']),
      performedBy: serializer.fromJson<String?>(json['performedBy']),
      actionType: serializer.fromJson<String>(json['actionType']),
      targetType: serializer.fromJson<String>(json['targetType']),
      targetId: serializer.fromJson<String>(json['targetId']),
      beforeSnapshot: serializer.fromJson<String?>(json['beforeSnapshot']),
      afterSnapshot: serializer.fromJson<String?>(json['afterSnapshot']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'performedBy': serializer.toJson<String?>(performedBy),
      'actionType': serializer.toJson<String>(actionType),
      'targetType': serializer.toJson<String>(targetType),
      'targetId': serializer.toJson<String>(targetId),
      'beforeSnapshot': serializer.toJson<String?>(beforeSnapshot),
      'afterSnapshot': serializer.toJson<String?>(afterSnapshot),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  AuditLogData copyWith({
    String? id,
    Value<String?> performedBy = const Value.absent(),
    String? actionType,
    String? targetType,
    String? targetId,
    Value<String?> beforeSnapshot = const Value.absent(),
    Value<String?> afterSnapshot = const Value.absent(),
    DateTime? timestamp,
  }) => AuditLogData(
    id: id ?? this.id,
    performedBy: performedBy.present ? performedBy.value : this.performedBy,
    actionType: actionType ?? this.actionType,
    targetType: targetType ?? this.targetType,
    targetId: targetId ?? this.targetId,
    beforeSnapshot: beforeSnapshot.present
        ? beforeSnapshot.value
        : this.beforeSnapshot,
    afterSnapshot: afterSnapshot.present
        ? afterSnapshot.value
        : this.afterSnapshot,
    timestamp: timestamp ?? this.timestamp,
  );
  AuditLogData copyWithCompanion(AuditLogCompanion data) {
    return AuditLogData(
      id: data.id.present ? data.id.value : this.id,
      performedBy: data.performedBy.present
          ? data.performedBy.value
          : this.performedBy,
      actionType: data.actionType.present
          ? data.actionType.value
          : this.actionType,
      targetType: data.targetType.present
          ? data.targetType.value
          : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      beforeSnapshot: data.beforeSnapshot.present
          ? data.beforeSnapshot.value
          : this.beforeSnapshot,
      afterSnapshot: data.afterSnapshot.present
          ? data.afterSnapshot.value
          : this.afterSnapshot,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogData(')
          ..write('id: $id, ')
          ..write('performedBy: $performedBy, ')
          ..write('actionType: $actionType, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('beforeSnapshot: $beforeSnapshot, ')
          ..write('afterSnapshot: $afterSnapshot, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    performedBy,
    actionType,
    targetType,
    targetId,
    beforeSnapshot,
    afterSnapshot,
    timestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogData &&
          other.id == this.id &&
          other.performedBy == this.performedBy &&
          other.actionType == this.actionType &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.beforeSnapshot == this.beforeSnapshot &&
          other.afterSnapshot == this.afterSnapshot &&
          other.timestamp == this.timestamp);
}

class AuditLogCompanion extends UpdateCompanion<AuditLogData> {
  final Value<String> id;
  final Value<String?> performedBy;
  final Value<String> actionType;
  final Value<String> targetType;
  final Value<String> targetId;
  final Value<String?> beforeSnapshot;
  final Value<String?> afterSnapshot;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const AuditLogCompanion({
    this.id = const Value.absent(),
    this.performedBy = const Value.absent(),
    this.actionType = const Value.absent(),
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.beforeSnapshot = const Value.absent(),
    this.afterSnapshot = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogCompanion.insert({
    required String id,
    this.performedBy = const Value.absent(),
    required String actionType,
    required String targetType,
    required String targetId,
    this.beforeSnapshot = const Value.absent(),
    this.afterSnapshot = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       actionType = Value(actionType),
       targetType = Value(targetType),
       targetId = Value(targetId);
  static Insertable<AuditLogData> custom({
    Expression<String>? id,
    Expression<String>? performedBy,
    Expression<String>? actionType,
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<String>? beforeSnapshot,
    Expression<String>? afterSnapshot,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (performedBy != null) 'performed_by': performedBy,
      if (actionType != null) 'action_type': actionType,
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (beforeSnapshot != null) 'before_snapshot': beforeSnapshot,
      if (afterSnapshot != null) 'after_snapshot': afterSnapshot,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogCompanion copyWith({
    Value<String>? id,
    Value<String?>? performedBy,
    Value<String>? actionType,
    Value<String>? targetType,
    Value<String>? targetId,
    Value<String?>? beforeSnapshot,
    Value<String?>? afterSnapshot,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return AuditLogCompanion(
      id: id ?? this.id,
      performedBy: performedBy ?? this.performedBy,
      actionType: actionType ?? this.actionType,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      beforeSnapshot: beforeSnapshot ?? this.beforeSnapshot,
      afterSnapshot: afterSnapshot ?? this.afterSnapshot,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (performedBy.present) {
      map['performed_by'] = Variable<String>(performedBy.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<String>(targetType.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (beforeSnapshot.present) {
      map['before_snapshot'] = Variable<String>(beforeSnapshot.value);
    }
    if (afterSnapshot.present) {
      map['after_snapshot'] = Variable<String>(afterSnapshot.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogCompanion(')
          ..write('id: $id, ')
          ..write('performedBy: $performedBy, ')
          ..write('actionType: $actionType, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('beforeSnapshot: $beforeSnapshot, ')
          ..write('afterSnapshot: $afterSnapshot, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CountDraftsTable extends CountDrafts
    with TableInfo<$CountDraftsTable, CountDraft> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountDraftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _actualQuantityMeta = const VerificationMeta(
    'actualQuantity',
  );
  @override
  late final GeneratedColumn<double> actualQuantity = GeneratedColumn<double>(
    'actual_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [productId, actualQuantity, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'count_drafts';
  @override
  VerificationContext validateIntegrity(
    Insertable<CountDraft> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('actual_quantity')) {
      context.handle(
        _actualQuantityMeta,
        actualQuantity.isAcceptableOrUnknown(
          data['actual_quantity']!,
          _actualQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualQuantityMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  CountDraft map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CountDraft(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      actualQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_quantity'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CountDraftsTable createAlias(String alias) {
    return $CountDraftsTable(attachedDatabase, alias);
  }
}

class CountDraft extends DataClass implements Insertable<CountDraft> {
  final String productId;
  final double actualQuantity;
  final DateTime updatedAt;
  const CountDraft({
    required this.productId,
    required this.actualQuantity,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['actual_quantity'] = Variable<double>(actualQuantity);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CountDraftsCompanion toCompanion(bool nullToAbsent) {
    return CountDraftsCompanion(
      productId: Value(productId),
      actualQuantity: Value(actualQuantity),
      updatedAt: Value(updatedAt),
    );
  }

  factory CountDraft.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountDraft(
      productId: serializer.fromJson<String>(json['productId']),
      actualQuantity: serializer.fromJson<double>(json['actualQuantity']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'actualQuantity': serializer.toJson<double>(actualQuantity),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CountDraft copyWith({
    String? productId,
    double? actualQuantity,
    DateTime? updatedAt,
  }) => CountDraft(
    productId: productId ?? this.productId,
    actualQuantity: actualQuantity ?? this.actualQuantity,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CountDraft copyWithCompanion(CountDraftsCompanion data) {
    return CountDraft(
      productId: data.productId.present ? data.productId.value : this.productId,
      actualQuantity: data.actualQuantity.present
          ? data.actualQuantity.value
          : this.actualQuantity,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CountDraft(')
          ..write('productId: $productId, ')
          ..write('actualQuantity: $actualQuantity, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, actualQuantity, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountDraft &&
          other.productId == this.productId &&
          other.actualQuantity == this.actualQuantity &&
          other.updatedAt == this.updatedAt);
}

class CountDraftsCompanion extends UpdateCompanion<CountDraft> {
  final Value<String> productId;
  final Value<double> actualQuantity;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CountDraftsCompanion({
    this.productId = const Value.absent(),
    this.actualQuantity = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CountDraftsCompanion.insert({
    required String productId,
    required double actualQuantity,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       actualQuantity = Value(actualQuantity);
  static Insertable<CountDraft> custom({
    Expression<String>? productId,
    Expression<double>? actualQuantity,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (actualQuantity != null) 'actual_quantity': actualQuantity,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CountDraftsCompanion copyWith({
    Value<String>? productId,
    Value<double>? actualQuantity,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CountDraftsCompanion(
      productId: productId ?? this.productId,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (actualQuantity.present) {
      map['actual_quantity'] = Variable<double>(actualQuantity.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountDraftsCompanion(')
          ..write('productId: $productId, ')
          ..write('actualQuantity: $actualQuantity, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTransactionsTable extends SalesTransactions
    with TableInfo<$SalesTransactionsTable, SalesTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemsSnapshotMeta = const VerificationMeta(
    'itemsSnapshot',
  );
  @override
  late final GeneratedColumn<String> itemsSnapshot = GeneratedColumn<String>(
    'items_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CASH'),
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    totalAmount,
    itemsSnapshot,
    paymentMethod,
    shiftId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('items_snapshot')) {
      context.handle(
        _itemsSnapshotMeta,
        itemsSnapshot.isAcceptableOrUnknown(
          data['items_snapshot']!,
          _itemsSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itemsSnapshotMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      itemsSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_snapshot'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shift_id'],
      ),
    );
  }

  @override
  $SalesTransactionsTable createAlias(String alias) {
    return $SalesTransactionsTable(attachedDatabase, alias);
  }
}

class SalesTransaction extends DataClass
    implements Insertable<SalesTransaction> {
  final int id;
  final DateTime timestamp;
  final double totalAmount;
  final String itemsSnapshot;
  final String paymentMethod;
  final int? shiftId;
  const SalesTransaction({
    required this.id,
    required this.timestamp,
    required this.totalAmount,
    required this.itemsSnapshot,
    required this.paymentMethod,
    this.shiftId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['total_amount'] = Variable<double>(totalAmount);
    map['items_snapshot'] = Variable<String>(itemsSnapshot);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<int>(shiftId);
    }
    return map;
  }

  SalesTransactionsCompanion toCompanion(bool nullToAbsent) {
    return SalesTransactionsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      totalAmount: Value(totalAmount),
      itemsSnapshot: Value(itemsSnapshot),
      paymentMethod: Value(paymentMethod),
      shiftId: shiftId == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftId),
    );
  }

  factory SalesTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesTransaction(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      itemsSnapshot: serializer.fromJson<String>(json['itemsSnapshot']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      shiftId: serializer.fromJson<int?>(json['shiftId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'itemsSnapshot': serializer.toJson<String>(itemsSnapshot),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'shiftId': serializer.toJson<int?>(shiftId),
    };
  }

  SalesTransaction copyWith({
    int? id,
    DateTime? timestamp,
    double? totalAmount,
    String? itemsSnapshot,
    String? paymentMethod,
    Value<int?> shiftId = const Value.absent(),
  }) => SalesTransaction(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    totalAmount: totalAmount ?? this.totalAmount,
    itemsSnapshot: itemsSnapshot ?? this.itemsSnapshot,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
  );
  SalesTransaction copyWithCompanion(SalesTransactionsCompanion data) {
    return SalesTransaction(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      itemsSnapshot: data.itemsSnapshot.present
          ? data.itemsSnapshot.value
          : this.itemsSnapshot,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesTransaction(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('itemsSnapshot: $itemsSnapshot, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('shiftId: $shiftId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    totalAmount,
    itemsSnapshot,
    paymentMethod,
    shiftId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesTransaction &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.totalAmount == this.totalAmount &&
          other.itemsSnapshot == this.itemsSnapshot &&
          other.paymentMethod == this.paymentMethod &&
          other.shiftId == this.shiftId);
}

class SalesTransactionsCompanion extends UpdateCompanion<SalesTransaction> {
  final Value<int> id;
  final Value<DateTime> timestamp;
  final Value<double> totalAmount;
  final Value<String> itemsSnapshot;
  final Value<String> paymentMethod;
  final Value<int?> shiftId;
  const SalesTransactionsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.itemsSnapshot = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.shiftId = const Value.absent(),
  });
  SalesTransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    required double totalAmount,
    required String itemsSnapshot,
    this.paymentMethod = const Value.absent(),
    this.shiftId = const Value.absent(),
  }) : totalAmount = Value(totalAmount),
       itemsSnapshot = Value(itemsSnapshot);
  static Insertable<SalesTransaction> custom({
    Expression<int>? id,
    Expression<DateTime>? timestamp,
    Expression<double>? totalAmount,
    Expression<String>? itemsSnapshot,
    Expression<String>? paymentMethod,
    Expression<int>? shiftId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (itemsSnapshot != null) 'items_snapshot': itemsSnapshot,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (shiftId != null) 'shift_id': shiftId,
    });
  }

  SalesTransactionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? timestamp,
    Value<double>? totalAmount,
    Value<String>? itemsSnapshot,
    Value<String>? paymentMethod,
    Value<int?>? shiftId,
  }) {
    return SalesTransactionsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      totalAmount: totalAmount ?? this.totalAmount,
      itemsSnapshot: itemsSnapshot ?? this.itemsSnapshot,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shiftId: shiftId ?? this.shiftId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (itemsSnapshot.present) {
      map['items_snapshot'] = Variable<String>(itemsSnapshot.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('itemsSnapshot: $itemsSnapshot, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('shiftId: $shiftId')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String name;
  final DateTime createdAt;
  const Customer({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith({String? id, String? name, DateTime? createdAt}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UtangLedgerTable extends UtangLedger
    with TableInfo<$UtangLedgerTable, UtangLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtangLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemsSnapshotMeta = const VerificationMeta(
    'itemsSnapshot',
  );
  @override
  late final GeneratedColumn<String> itemsSnapshot = GeneratedColumn<String>(
    'items_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    amount,
    timestamp,
    description,
    shiftId,
    itemsSnapshot,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utang_ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtangLedgerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    }
    if (data.containsKey('items_snapshot')) {
      context.handle(
        _itemsSnapshotMeta,
        itemsSnapshot.isAcceptableOrUnknown(
          data['items_snapshot']!,
          _itemsSnapshotMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UtangLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtangLedgerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shift_id'],
      ),
      itemsSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_snapshot'],
      ),
    );
  }

  @override
  $UtangLedgerTable createAlias(String alias) {
    return $UtangLedgerTable(attachedDatabase, alias);
  }
}

class UtangLedgerData extends DataClass implements Insertable<UtangLedgerData> {
  final String id;
  final String customerId;
  final double amount;
  final DateTime timestamp;
  final String? description;
  final int? shiftId;
  final String? itemsSnapshot;
  const UtangLedgerData({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.timestamp,
    this.description,
    this.shiftId,
    this.itemsSnapshot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['amount'] = Variable<double>(amount);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<int>(shiftId);
    }
    if (!nullToAbsent || itemsSnapshot != null) {
      map['items_snapshot'] = Variable<String>(itemsSnapshot);
    }
    return map;
  }

  UtangLedgerCompanion toCompanion(bool nullToAbsent) {
    return UtangLedgerCompanion(
      id: Value(id),
      customerId: Value(customerId),
      amount: Value(amount),
      timestamp: Value(timestamp),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      shiftId: shiftId == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftId),
      itemsSnapshot: itemsSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(itemsSnapshot),
    );
  }

  factory UtangLedgerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtangLedgerData(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      amount: serializer.fromJson<double>(json['amount']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      description: serializer.fromJson<String?>(json['description']),
      shiftId: serializer.fromJson<int?>(json['shiftId']),
      itemsSnapshot: serializer.fromJson<String?>(json['itemsSnapshot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String>(customerId),
      'amount': serializer.toJson<double>(amount),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'description': serializer.toJson<String?>(description),
      'shiftId': serializer.toJson<int?>(shiftId),
      'itemsSnapshot': serializer.toJson<String?>(itemsSnapshot),
    };
  }

  UtangLedgerData copyWith({
    String? id,
    String? customerId,
    double? amount,
    DateTime? timestamp,
    Value<String?> description = const Value.absent(),
    Value<int?> shiftId = const Value.absent(),
    Value<String?> itemsSnapshot = const Value.absent(),
  }) => UtangLedgerData(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    amount: amount ?? this.amount,
    timestamp: timestamp ?? this.timestamp,
    description: description.present ? description.value : this.description,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
    itemsSnapshot: itemsSnapshot.present
        ? itemsSnapshot.value
        : this.itemsSnapshot,
  );
  UtangLedgerData copyWithCompanion(UtangLedgerCompanion data) {
    return UtangLedgerData(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      description: data.description.present
          ? data.description.value
          : this.description,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      itemsSnapshot: data.itemsSnapshot.present
          ? data.itemsSnapshot.value
          : this.itemsSnapshot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtangLedgerData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('timestamp: $timestamp, ')
          ..write('description: $description, ')
          ..write('shiftId: $shiftId, ')
          ..write('itemsSnapshot: $itemsSnapshot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    amount,
    timestamp,
    description,
    shiftId,
    itemsSnapshot,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtangLedgerData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.amount == this.amount &&
          other.timestamp == this.timestamp &&
          other.description == this.description &&
          other.shiftId == this.shiftId &&
          other.itemsSnapshot == this.itemsSnapshot);
}

class UtangLedgerCompanion extends UpdateCompanion<UtangLedgerData> {
  final Value<String> id;
  final Value<String> customerId;
  final Value<double> amount;
  final Value<DateTime> timestamp;
  final Value<String?> description;
  final Value<int?> shiftId;
  final Value<String?> itemsSnapshot;
  final Value<int> rowid;
  const UtangLedgerCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.description = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.itemsSnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtangLedgerCompanion.insert({
    required String id,
    required String customerId,
    required double amount,
    this.timestamp = const Value.absent(),
    this.description = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.itemsSnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       customerId = Value(customerId),
       amount = Value(amount);
  static Insertable<UtangLedgerData> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<double>? amount,
    Expression<DateTime>? timestamp,
    Expression<String>? description,
    Expression<int>? shiftId,
    Expression<String>? itemsSnapshot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (amount != null) 'amount': amount,
      if (timestamp != null) 'timestamp': timestamp,
      if (description != null) 'description': description,
      if (shiftId != null) 'shift_id': shiftId,
      if (itemsSnapshot != null) 'items_snapshot': itemsSnapshot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtangLedgerCompanion copyWith({
    Value<String>? id,
    Value<String>? customerId,
    Value<double>? amount,
    Value<DateTime>? timestamp,
    Value<String?>? description,
    Value<int?>? shiftId,
    Value<String?>? itemsSnapshot,
    Value<int>? rowid,
  }) {
    return UtangLedgerCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      description: description ?? this.description,
      shiftId: shiftId ?? this.shiftId,
      itemsSnapshot: itemsSnapshot ?? this.itemsSnapshot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (itemsSnapshot.present) {
      map['items_snapshot'] = Variable<String>(itemsSnapshot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtangLedgerCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('timestamp: $timestamp, ')
          ..write('description: $description, ')
          ..write('shiftId: $shiftId, ')
          ..write('itemsSnapshot: $itemsSnapshot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoreExpensesTable extends StoreExpenses
    with TableInfo<$StoreExpensesTable, StoreExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoreExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    description,
    timestamp,
    shiftId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'store_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoreExpense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoreExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreExpense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shift_id'],
      ),
    );
  }

  @override
  $StoreExpensesTable createAlias(String alias) {
    return $StoreExpensesTable(attachedDatabase, alias);
  }
}

class StoreExpense extends DataClass implements Insertable<StoreExpense> {
  final int id;
  final double amount;
  final String description;
  final DateTime timestamp;
  final int? shiftId;
  const StoreExpense({
    required this.id,
    required this.amount,
    required this.description,
    required this.timestamp,
    this.shiftId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<int>(shiftId);
    }
    return map;
  }

  StoreExpensesCompanion toCompanion(bool nullToAbsent) {
    return StoreExpensesCompanion(
      id: Value(id),
      amount: Value(amount),
      description: Value(description),
      timestamp: Value(timestamp),
      shiftId: shiftId == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftId),
    );
  }

  factory StoreExpense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreExpense(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      shiftId: serializer.fromJson<int?>(json['shiftId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'shiftId': serializer.toJson<int?>(shiftId),
    };
  }

  StoreExpense copyWith({
    int? id,
    double? amount,
    String? description,
    DateTime? timestamp,
    Value<int?> shiftId = const Value.absent(),
  }) => StoreExpense(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    description: description ?? this.description,
    timestamp: timestamp ?? this.timestamp,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
  );
  StoreExpense copyWithCompanion(StoreExpensesCompanion data) {
    return StoreExpense(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      description: data.description.present
          ? data.description.value
          : this.description,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreExpense(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('timestamp: $timestamp, ')
          ..write('shiftId: $shiftId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, description, timestamp, shiftId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreExpense &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.timestamp == this.timestamp &&
          other.shiftId == this.shiftId);
}

class StoreExpensesCompanion extends UpdateCompanion<StoreExpense> {
  final Value<int> id;
  final Value<double> amount;
  final Value<String> description;
  final Value<DateTime> timestamp;
  final Value<int?> shiftId;
  const StoreExpensesCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.shiftId = const Value.absent(),
  });
  StoreExpensesCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    required String description,
    this.timestamp = const Value.absent(),
    this.shiftId = const Value.absent(),
  }) : amount = Value(amount),
       description = Value(description);
  static Insertable<StoreExpense> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<DateTime>? timestamp,
    Expression<int>? shiftId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (timestamp != null) 'timestamp': timestamp,
      if (shiftId != null) 'shift_id': shiftId,
    });
  }

  StoreExpensesCompanion copyWith({
    Value<int>? id,
    Value<double>? amount,
    Value<String>? description,
    Value<DateTime>? timestamp,
    Value<int?>? shiftId,
  }) {
    return StoreExpensesCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      shiftId: shiftId ?? this.shiftId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoreExpensesCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('timestamp: $timestamp, ')
          ..write('shiftId: $shiftId')
          ..write(')'))
        .toString();
  }
}

class $CashierShiftsTable extends CashierShifts
    with TableInfo<$CashierShiftsTable, CashierShift> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashierShiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cashierNameMeta = const VerificationMeta(
    'cashierName',
  );
  @override
  late final GeneratedColumn<String> cashierName = GeneratedColumn<String>(
    'cashier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openingFloatMeta = const VerificationMeta(
    'openingFloat',
  );
  @override
  late final GeneratedColumn<double> openingFloat = GeneratedColumn<double>(
    'opening_float',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedClosingFloatMeta =
      const VerificationMeta('expectedClosingFloat');
  @override
  late final GeneratedColumn<double> expectedClosingFloat =
      GeneratedColumn<double>(
        'expected_closing_float',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _actualClosingFloatMeta =
      const VerificationMeta('actualClosingFloat');
  @override
  late final GeneratedColumn<double> actualClosingFloat =
      GeneratedColumn<double>(
        'actual_closing_float',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _varianceMeta = const VerificationMeta(
    'variance',
  );
  @override
  late final GeneratedColumn<double> variance = GeneratedColumn<double>(
    'variance',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cashierName,
    startTime,
    endTime,
    openingFloat,
    expectedClosingFloat,
    actualClosingFloat,
    variance,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cashier_shifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashierShift> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cashier_name')) {
      context.handle(
        _cashierNameMeta,
        cashierName.isAcceptableOrUnknown(
          data['cashier_name']!,
          _cashierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cashierNameMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('opening_float')) {
      context.handle(
        _openingFloatMeta,
        openingFloat.isAcceptableOrUnknown(
          data['opening_float']!,
          _openingFloatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingFloatMeta);
    }
    if (data.containsKey('expected_closing_float')) {
      context.handle(
        _expectedClosingFloatMeta,
        expectedClosingFloat.isAcceptableOrUnknown(
          data['expected_closing_float']!,
          _expectedClosingFloatMeta,
        ),
      );
    }
    if (data.containsKey('actual_closing_float')) {
      context.handle(
        _actualClosingFloatMeta,
        actualClosingFloat.isAcceptableOrUnknown(
          data['actual_closing_float']!,
          _actualClosingFloatMeta,
        ),
      );
    }
    if (data.containsKey('variance')) {
      context.handle(
        _varianceMeta,
        variance.isAcceptableOrUnknown(data['variance']!, _varianceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashierShift map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashierShift(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cashierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cashier_name'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      openingFloat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}opening_float'],
      )!,
      expectedClosingFloat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_closing_float'],
      ),
      actualClosingFloat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_closing_float'],
      ),
      variance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}variance'],
      ),
    );
  }

  @override
  $CashierShiftsTable createAlias(String alias) {
    return $CashierShiftsTable(attachedDatabase, alias);
  }
}

class CashierShift extends DataClass implements Insertable<CashierShift> {
  final int id;
  final String cashierName;
  final DateTime startTime;
  final DateTime? endTime;
  final double openingFloat;
  final double? expectedClosingFloat;
  final double? actualClosingFloat;
  final double? variance;
  const CashierShift({
    required this.id,
    required this.cashierName,
    required this.startTime,
    this.endTime,
    required this.openingFloat,
    this.expectedClosingFloat,
    this.actualClosingFloat,
    this.variance,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cashier_name'] = Variable<String>(cashierName);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['opening_float'] = Variable<double>(openingFloat);
    if (!nullToAbsent || expectedClosingFloat != null) {
      map['expected_closing_float'] = Variable<double>(expectedClosingFloat);
    }
    if (!nullToAbsent || actualClosingFloat != null) {
      map['actual_closing_float'] = Variable<double>(actualClosingFloat);
    }
    if (!nullToAbsent || variance != null) {
      map['variance'] = Variable<double>(variance);
    }
    return map;
  }

  CashierShiftsCompanion toCompanion(bool nullToAbsent) {
    return CashierShiftsCompanion(
      id: Value(id),
      cashierName: Value(cashierName),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      openingFloat: Value(openingFloat),
      expectedClosingFloat: expectedClosingFloat == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedClosingFloat),
      actualClosingFloat: actualClosingFloat == null && nullToAbsent
          ? const Value.absent()
          : Value(actualClosingFloat),
      variance: variance == null && nullToAbsent
          ? const Value.absent()
          : Value(variance),
    );
  }

  factory CashierShift.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashierShift(
      id: serializer.fromJson<int>(json['id']),
      cashierName: serializer.fromJson<String>(json['cashierName']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      openingFloat: serializer.fromJson<double>(json['openingFloat']),
      expectedClosingFloat: serializer.fromJson<double?>(
        json['expectedClosingFloat'],
      ),
      actualClosingFloat: serializer.fromJson<double?>(
        json['actualClosingFloat'],
      ),
      variance: serializer.fromJson<double?>(json['variance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cashierName': serializer.toJson<String>(cashierName),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'openingFloat': serializer.toJson<double>(openingFloat),
      'expectedClosingFloat': serializer.toJson<double?>(expectedClosingFloat),
      'actualClosingFloat': serializer.toJson<double?>(actualClosingFloat),
      'variance': serializer.toJson<double?>(variance),
    };
  }

  CashierShift copyWith({
    int? id,
    String? cashierName,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    double? openingFloat,
    Value<double?> expectedClosingFloat = const Value.absent(),
    Value<double?> actualClosingFloat = const Value.absent(),
    Value<double?> variance = const Value.absent(),
  }) => CashierShift(
    id: id ?? this.id,
    cashierName: cashierName ?? this.cashierName,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    openingFloat: openingFloat ?? this.openingFloat,
    expectedClosingFloat: expectedClosingFloat.present
        ? expectedClosingFloat.value
        : this.expectedClosingFloat,
    actualClosingFloat: actualClosingFloat.present
        ? actualClosingFloat.value
        : this.actualClosingFloat,
    variance: variance.present ? variance.value : this.variance,
  );
  CashierShift copyWithCompanion(CashierShiftsCompanion data) {
    return CashierShift(
      id: data.id.present ? data.id.value : this.id,
      cashierName: data.cashierName.present
          ? data.cashierName.value
          : this.cashierName,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      openingFloat: data.openingFloat.present
          ? data.openingFloat.value
          : this.openingFloat,
      expectedClosingFloat: data.expectedClosingFloat.present
          ? data.expectedClosingFloat.value
          : this.expectedClosingFloat,
      actualClosingFloat: data.actualClosingFloat.present
          ? data.actualClosingFloat.value
          : this.actualClosingFloat,
      variance: data.variance.present ? data.variance.value : this.variance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashierShift(')
          ..write('id: $id, ')
          ..write('cashierName: $cashierName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('openingFloat: $openingFloat, ')
          ..write('expectedClosingFloat: $expectedClosingFloat, ')
          ..write('actualClosingFloat: $actualClosingFloat, ')
          ..write('variance: $variance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cashierName,
    startTime,
    endTime,
    openingFloat,
    expectedClosingFloat,
    actualClosingFloat,
    variance,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashierShift &&
          other.id == this.id &&
          other.cashierName == this.cashierName &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.openingFloat == this.openingFloat &&
          other.expectedClosingFloat == this.expectedClosingFloat &&
          other.actualClosingFloat == this.actualClosingFloat &&
          other.variance == this.variance);
}

class CashierShiftsCompanion extends UpdateCompanion<CashierShift> {
  final Value<int> id;
  final Value<String> cashierName;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<double> openingFloat;
  final Value<double?> expectedClosingFloat;
  final Value<double?> actualClosingFloat;
  final Value<double?> variance;
  const CashierShiftsCompanion({
    this.id = const Value.absent(),
    this.cashierName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.openingFloat = const Value.absent(),
    this.expectedClosingFloat = const Value.absent(),
    this.actualClosingFloat = const Value.absent(),
    this.variance = const Value.absent(),
  });
  CashierShiftsCompanion.insert({
    this.id = const Value.absent(),
    required String cashierName,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    required double openingFloat,
    this.expectedClosingFloat = const Value.absent(),
    this.actualClosingFloat = const Value.absent(),
    this.variance = const Value.absent(),
  }) : cashierName = Value(cashierName),
       openingFloat = Value(openingFloat);
  static Insertable<CashierShift> custom({
    Expression<int>? id,
    Expression<String>? cashierName,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<double>? openingFloat,
    Expression<double>? expectedClosingFloat,
    Expression<double>? actualClosingFloat,
    Expression<double>? variance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cashierName != null) 'cashier_name': cashierName,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (openingFloat != null) 'opening_float': openingFloat,
      if (expectedClosingFloat != null)
        'expected_closing_float': expectedClosingFloat,
      if (actualClosingFloat != null)
        'actual_closing_float': actualClosingFloat,
      if (variance != null) 'variance': variance,
    });
  }

  CashierShiftsCompanion copyWith({
    Value<int>? id,
    Value<String>? cashierName,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<double>? openingFloat,
    Value<double?>? expectedClosingFloat,
    Value<double?>? actualClosingFloat,
    Value<double?>? variance,
  }) {
    return CashierShiftsCompanion(
      id: id ?? this.id,
      cashierName: cashierName ?? this.cashierName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      openingFloat: openingFloat ?? this.openingFloat,
      expectedClosingFloat: expectedClosingFloat ?? this.expectedClosingFloat,
      actualClosingFloat: actualClosingFloat ?? this.actualClosingFloat,
      variance: variance ?? this.variance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cashierName.present) {
      map['cashier_name'] = Variable<String>(cashierName.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (openingFloat.present) {
      map['opening_float'] = Variable<double>(openingFloat.value);
    }
    if (expectedClosingFloat.present) {
      map['expected_closing_float'] = Variable<double>(
        expectedClosingFloat.value,
      );
    }
    if (actualClosingFloat.present) {
      map['actual_closing_float'] = Variable<double>(actualClosingFloat.value);
    }
    if (variance.present) {
      map['variance'] = Variable<double>(variance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashierShiftsCompanion(')
          ..write('id: $id, ')
          ..write('cashierName: $cashierName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('openingFloat: $openingFloat, ')
          ..write('expectedClosingFloat: $expectedClosingFloat, ')
          ..write('actualClosingFloat: $actualClosingFloat, ')
          ..write('variance: $variance')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StockInEventsTable stockInEvents = $StockInEventsTable(this);
  late final $StockInItemsTable stockInItems = $StockInItemsTable(this);
  late final $CountSessionsTable countSessions = $CountSessionsTable(this);
  late final $CountItemsTable countItems = $CountItemsTable(this);
  late final $AlertsTable alerts = $AlertsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $AuditLogTable auditLog = $AuditLogTable(this);
  late final $CountDraftsTable countDrafts = $CountDraftsTable(this);
  late final $SalesTransactionsTable salesTransactions =
      $SalesTransactionsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $UtangLedgerTable utangLedger = $UtangLedgerTable(this);
  late final $StoreExpensesTable storeExpenses = $StoreExpensesTable(this);
  late final $CashierShiftsTable cashierShifts = $CashierShiftsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    stockInEvents,
    stockInItems,
    countSessions,
    countItems,
    alerts,
    users,
    auditLog,
    countDrafts,
    salesTransactions,
    customers,
    utangLedger,
    storeExpenses,
    cashierShifts,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      Value<String?> barcode,
      required String name,
      required String category,
      required String unit,
      required double reorderPoint,
      Value<double> averageCost,
      Value<double?> averageSellingPrice,
      Value<double> burnRatePerDay,
      Value<double> lastActualQuantity,
      Value<double> currentStock,
      Value<DateTime?> lastCountedAt,
      Value<DateTime?> lastBurnRateUpdate,
      Value<bool> isActive,
      Value<bool> isSeeded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String?> barcode,
      Value<String> name,
      Value<String> category,
      Value<String> unit,
      Value<double> reorderPoint,
      Value<double> averageCost,
      Value<double?> averageSellingPrice,
      Value<double> burnRatePerDay,
      Value<double> lastActualQuantity,
      Value<double> currentStock,
      Value<DateTime?> lastCountedAt,
      Value<DateTime?> lastBurnRateUpdate,
      Value<bool> isActive,
      Value<bool> isSeeded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StockInItemsTable, List<StockInItem>>
  _stockInItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockInItems,
    aliasName: $_aliasNameGenerator(db.products.id, db.stockInItems.productId),
  );

  $$StockInItemsTableProcessedTableManager get stockInItemsRefs {
    final manager = $$StockInItemsTableTableManager(
      $_db,
      $_db.stockInItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockInItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CountItemsTable, List<CountItem>>
  _countItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.countItems,
    aliasName: $_aliasNameGenerator(db.products.id, db.countItems.productId),
  );

  $$CountItemsTableProcessedTableManager get countItemsRefs {
    final manager = $$CountItemsTableTableManager(
      $_db,
      $_db.countItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_countItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlertsTable, List<Alert>> _alertsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.alerts,
    aliasName: $_aliasNameGenerator(db.products.id, db.alerts.productId),
  );

  $$AlertsTableProcessedTableManager get alertsRefs {
    final manager = $$AlertsTableTableManager(
      $_db,
      $_db.alerts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_alertsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CountDraftsTable, List<CountDraft>>
  _countDraftsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.countDrafts,
    aliasName: $_aliasNameGenerator(db.products.id, db.countDrafts.productId),
  );

  $$CountDraftsTableProcessedTableManager get countDraftsRefs {
    final manager = $$CountDraftsTableTableManager(
      $_db,
      $_db.countDrafts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_countDraftsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageCost => $composableBuilder(
    column: $table.averageCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageSellingPrice => $composableBuilder(
    column: $table.averageSellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get burnRatePerDay => $composableBuilder(
    column: $table.burnRatePerDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastActualQuantity => $composableBuilder(
    column: $table.lastActualQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCountedAt => $composableBuilder(
    column: $table.lastCountedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBurnRateUpdate => $composableBuilder(
    column: $table.lastBurnRateUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSeeded => $composableBuilder(
    column: $table.isSeeded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> stockInItemsRefs(
    Expression<bool> Function($$StockInItemsTableFilterComposer f) f,
  ) {
    final $$StockInItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockInItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInItemsTableFilterComposer(
            $db: $db,
            $table: $db.stockInItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> countItemsRefs(
    Expression<bool> Function($$CountItemsTableFilterComposer f) f,
  ) {
    final $$CountItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountItemsTableFilterComposer(
            $db: $db,
            $table: $db.countItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> alertsRefs(
    Expression<bool> Function($$AlertsTableFilterComposer f) f,
  ) {
    final $$AlertsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alerts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlertsTableFilterComposer(
            $db: $db,
            $table: $db.alerts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> countDraftsRefs(
    Expression<bool> Function($$CountDraftsTableFilterComposer f) f,
  ) {
    final $$CountDraftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countDrafts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountDraftsTableFilterComposer(
            $db: $db,
            $table: $db.countDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageCost => $composableBuilder(
    column: $table.averageCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageSellingPrice => $composableBuilder(
    column: $table.averageSellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get burnRatePerDay => $composableBuilder(
    column: $table.burnRatePerDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastActualQuantity => $composableBuilder(
    column: $table.lastActualQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCountedAt => $composableBuilder(
    column: $table.lastCountedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBurnRateUpdate => $composableBuilder(
    column: $table.lastBurnRateUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSeeded => $composableBuilder(
    column: $table.isSeeded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => column,
  );

  GeneratedColumn<double> get averageCost => $composableBuilder(
    column: $table.averageCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get averageSellingPrice => $composableBuilder(
    column: $table.averageSellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get burnRatePerDay => $composableBuilder(
    column: $table.burnRatePerDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastActualQuantity => $composableBuilder(
    column: $table.lastActualQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCountedAt => $composableBuilder(
    column: $table.lastCountedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBurnRateUpdate => $composableBuilder(
    column: $table.lastBurnRateUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isSeeded =>
      $composableBuilder(column: $table.isSeeded, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> stockInItemsRefs<T extends Object>(
    Expression<T> Function($$StockInItemsTableAnnotationComposer a) f,
  ) {
    final $$StockInItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockInItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockInItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> countItemsRefs<T extends Object>(
    Expression<T> Function($$CountItemsTableAnnotationComposer a) f,
  ) {
    final $$CountItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.countItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> alertsRefs<T extends Object>(
    Expression<T> Function($$AlertsTableAnnotationComposer a) f,
  ) {
    final $$AlertsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alerts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlertsTableAnnotationComposer(
            $db: $db,
            $table: $db.alerts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> countDraftsRefs<T extends Object>(
    Expression<T> Function($$CountDraftsTableAnnotationComposer a) f,
  ) {
    final $$CountDraftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countDrafts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountDraftsTableAnnotationComposer(
            $db: $db,
            $table: $db.countDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool stockInItemsRefs,
            bool countItemsRefs,
            bool alertsRefs,
            bool countDraftsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> reorderPoint = const Value.absent(),
                Value<double> averageCost = const Value.absent(),
                Value<double?> averageSellingPrice = const Value.absent(),
                Value<double> burnRatePerDay = const Value.absent(),
                Value<double> lastActualQuantity = const Value.absent(),
                Value<double> currentStock = const Value.absent(),
                Value<DateTime?> lastCountedAt = const Value.absent(),
                Value<DateTime?> lastBurnRateUpdate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isSeeded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                barcode: barcode,
                name: name,
                category: category,
                unit: unit,
                reorderPoint: reorderPoint,
                averageCost: averageCost,
                averageSellingPrice: averageSellingPrice,
                burnRatePerDay: burnRatePerDay,
                lastActualQuantity: lastActualQuantity,
                currentStock: currentStock,
                lastCountedAt: lastCountedAt,
                lastBurnRateUpdate: lastBurnRateUpdate,
                isActive: isActive,
                isSeeded: isSeeded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> barcode = const Value.absent(),
                required String name,
                required String category,
                required String unit,
                required double reorderPoint,
                Value<double> averageCost = const Value.absent(),
                Value<double?> averageSellingPrice = const Value.absent(),
                Value<double> burnRatePerDay = const Value.absent(),
                Value<double> lastActualQuantity = const Value.absent(),
                Value<double> currentStock = const Value.absent(),
                Value<DateTime?> lastCountedAt = const Value.absent(),
                Value<DateTime?> lastBurnRateUpdate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isSeeded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                barcode: barcode,
                name: name,
                category: category,
                unit: unit,
                reorderPoint: reorderPoint,
                averageCost: averageCost,
                averageSellingPrice: averageSellingPrice,
                burnRatePerDay: burnRatePerDay,
                lastActualQuantity: lastActualQuantity,
                currentStock: currentStock,
                lastCountedAt: lastCountedAt,
                lastBurnRateUpdate: lastBurnRateUpdate,
                isActive: isActive,
                isSeeded: isSeeded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                stockInItemsRefs = false,
                countItemsRefs = false,
                alertsRefs = false,
                countDraftsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (stockInItemsRefs) db.stockInItems,
                    if (countItemsRefs) db.countItems,
                    if (alertsRefs) db.alerts,
                    if (countDraftsRefs) db.countDrafts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (stockInItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          StockInItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._stockInItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockInItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (countItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          CountItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._countItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).countItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (alertsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          Alert
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._alertsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).alertsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (countDraftsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          CountDraft
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._countDraftsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).countDraftsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool stockInItemsRefs,
        bool countItemsRefs,
        bool alertsRefs,
        bool countDraftsRefs,
      })
    >;
typedef $$StockInEventsTableCreateCompanionBuilder =
    StockInEventsCompanion Function({
      required String id,
      required String supplierName,
      required DateTime deliveryDate,
      Value<String?> loggedBy,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$StockInEventsTableUpdateCompanionBuilder =
    StockInEventsCompanion Function({
      Value<String> id,
      Value<String> supplierName,
      Value<DateTime> deliveryDate,
      Value<String?> loggedBy,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$StockInEventsTableReferences
    extends BaseReferences<_$AppDatabase, $StockInEventsTable, StockInEvent> {
  $$StockInEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StockInItemsTable, List<StockInItem>>
  _stockInItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockInItems,
    aliasName: $_aliasNameGenerator(
      db.stockInEvents.id,
      db.stockInItems.stockInEventId,
    ),
  );

  $$StockInItemsTableProcessedTableManager get stockInItemsRefs {
    final manager = $$StockInItemsTableTableManager(
      $_db,
      $_db.stockInItems,
    ).filter((f) => f.stockInEventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockInItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StockInEventsTableFilterComposer
    extends Composer<_$AppDatabase, $StockInEventsTable> {
  $$StockInEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loggedBy => $composableBuilder(
    column: $table.loggedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> stockInItemsRefs(
    Expression<bool> Function($$StockInItemsTableFilterComposer f) f,
  ) {
    final $$StockInItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockInItems,
      getReferencedColumn: (t) => t.stockInEventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInItemsTableFilterComposer(
            $db: $db,
            $table: $db.stockInItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StockInEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockInEventsTable> {
  $$StockInEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loggedBy => $composableBuilder(
    column: $table.loggedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockInEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockInEventsTable> {
  $$StockInEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loggedBy =>
      $composableBuilder(column: $table.loggedBy, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> stockInItemsRefs<T extends Object>(
    Expression<T> Function($$StockInItemsTableAnnotationComposer a) f,
  ) {
    final $$StockInItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockInItems,
      getReferencedColumn: (t) => t.stockInEventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockInItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StockInEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockInEventsTable,
          StockInEvent,
          $$StockInEventsTableFilterComposer,
          $$StockInEventsTableOrderingComposer,
          $$StockInEventsTableAnnotationComposer,
          $$StockInEventsTableCreateCompanionBuilder,
          $$StockInEventsTableUpdateCompanionBuilder,
          (StockInEvent, $$StockInEventsTableReferences),
          StockInEvent,
          PrefetchHooks Function({bool stockInItemsRefs})
        > {
  $$StockInEventsTableTableManager(_$AppDatabase db, $StockInEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockInEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockInEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockInEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> supplierName = const Value.absent(),
                Value<DateTime> deliveryDate = const Value.absent(),
                Value<String?> loggedBy = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockInEventsCompanion(
                id: id,
                supplierName: supplierName,
                deliveryDate: deliveryDate,
                loggedBy: loggedBy,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String supplierName,
                required DateTime deliveryDate,
                Value<String?> loggedBy = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockInEventsCompanion.insert(
                id: id,
                supplierName: supplierName,
                deliveryDate: deliveryDate,
                loggedBy: loggedBy,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockInEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stockInItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (stockInItemsRefs) db.stockInItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockInItemsRefs)
                    await $_getPrefetchedData<
                      StockInEvent,
                      $StockInEventsTable,
                      StockInItem
                    >(
                      currentTable: table,
                      referencedTable: $$StockInEventsTableReferences
                          ._stockInItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StockInEventsTableReferences(
                            db,
                            table,
                            p0,
                          ).stockInItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.stockInEventId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StockInEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockInEventsTable,
      StockInEvent,
      $$StockInEventsTableFilterComposer,
      $$StockInEventsTableOrderingComposer,
      $$StockInEventsTableAnnotationComposer,
      $$StockInEventsTableCreateCompanionBuilder,
      $$StockInEventsTableUpdateCompanionBuilder,
      (StockInEvent, $$StockInEventsTableReferences),
      StockInEvent,
      PrefetchHooks Function({bool stockInItemsRefs})
    >;
typedef $$StockInItemsTableCreateCompanionBuilder =
    StockInItemsCompanion Function({
      required String id,
      required String stockInEventId,
      required String productId,
      required double quantity,
      required double unitCost,
      Value<int> rowid,
    });
typedef $$StockInItemsTableUpdateCompanionBuilder =
    StockInItemsCompanion Function({
      Value<String> id,
      Value<String> stockInEventId,
      Value<String> productId,
      Value<double> quantity,
      Value<double> unitCost,
      Value<int> rowid,
    });

final class $$StockInItemsTableReferences
    extends BaseReferences<_$AppDatabase, $StockInItemsTable, StockInItem> {
  $$StockInItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StockInEventsTable _stockInEventIdTable(_$AppDatabase db) =>
      db.stockInEvents.createAlias(
        $_aliasNameGenerator(
          db.stockInItems.stockInEventId,
          db.stockInEvents.id,
        ),
      );

  $$StockInEventsTableProcessedTableManager get stockInEventId {
    final $_column = $_itemColumn<String>('stock_in_event_id')!;

    final manager = $$StockInEventsTableTableManager(
      $_db,
      $_db.stockInEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stockInEventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.stockInItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockInItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StockInItemsTable> {
  $$StockInItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  $$StockInEventsTableFilterComposer get stockInEventId {
    final $$StockInEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stockInEventId,
      referencedTable: $db.stockInEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInEventsTableFilterComposer(
            $db: $db,
            $table: $db.stockInEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockInItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockInItemsTable> {
  $$StockInItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  $$StockInEventsTableOrderingComposer get stockInEventId {
    final $$StockInEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stockInEventId,
      referencedTable: $db.stockInEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInEventsTableOrderingComposer(
            $db: $db,
            $table: $db.stockInEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockInItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockInItemsTable> {
  $$StockInItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  $$StockInEventsTableAnnotationComposer get stockInEventId {
    final $$StockInEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stockInEventId,
      referencedTable: $db.stockInEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockInEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockInEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockInItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockInItemsTable,
          StockInItem,
          $$StockInItemsTableFilterComposer,
          $$StockInItemsTableOrderingComposer,
          $$StockInItemsTableAnnotationComposer,
          $$StockInItemsTableCreateCompanionBuilder,
          $$StockInItemsTableUpdateCompanionBuilder,
          (StockInItem, $$StockInItemsTableReferences),
          StockInItem,
          PrefetchHooks Function({bool stockInEventId, bool productId})
        > {
  $$StockInItemsTableTableManager(_$AppDatabase db, $StockInItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockInItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockInItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockInItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> stockInEventId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockInItemsCompanion(
                id: id,
                stockInEventId: stockInEventId,
                productId: productId,
                quantity: quantity,
                unitCost: unitCost,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String stockInEventId,
                required String productId,
                required double quantity,
                required double unitCost,
                Value<int> rowid = const Value.absent(),
              }) => StockInItemsCompanion.insert(
                id: id,
                stockInEventId: stockInEventId,
                productId: productId,
                quantity: quantity,
                unitCost: unitCost,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockInItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stockInEventId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stockInEventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stockInEventId,
                                referencedTable: $$StockInItemsTableReferences
                                    ._stockInEventIdTable(db),
                                referencedColumn: $$StockInItemsTableReferences
                                    ._stockInEventIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$StockInItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$StockInItemsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockInItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockInItemsTable,
      StockInItem,
      $$StockInItemsTableFilterComposer,
      $$StockInItemsTableOrderingComposer,
      $$StockInItemsTableAnnotationComposer,
      $$StockInItemsTableCreateCompanionBuilder,
      $$StockInItemsTableUpdateCompanionBuilder,
      (StockInItem, $$StockInItemsTableReferences),
      StockInItem,
      PrefetchHooks Function({bool stockInEventId, bool productId})
    >;
typedef $$CountSessionsTableCreateCompanionBuilder =
    CountSessionsCompanion Function({
      required String id,
      required String countType,
      Value<String?> countedBy,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$CountSessionsTableUpdateCompanionBuilder =
    CountSessionsCompanion Function({
      Value<String> id,
      Value<String> countType,
      Value<String?> countedBy,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$CountSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $CountSessionsTable, CountSession> {
  $$CountSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CountItemsTable, List<CountItem>>
  _countItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.countItems,
    aliasName: $_aliasNameGenerator(
      db.countSessions.id,
      db.countItems.countSessionId,
    ),
  );

  $$CountItemsTableProcessedTableManager get countItemsRefs {
    final manager = $$CountItemsTableTableManager(
      $_db,
      $_db.countItems,
    ).filter((f) => f.countSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_countItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CountSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $CountSessionsTable> {
  $$CountSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countType => $composableBuilder(
    column: $table.countType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countedBy => $composableBuilder(
    column: $table.countedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> countItemsRefs(
    Expression<bool> Function($$CountItemsTableFilterComposer f) f,
  ) {
    final $$CountItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countItems,
      getReferencedColumn: (t) => t.countSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountItemsTableFilterComposer(
            $db: $db,
            $table: $db.countItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CountSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CountSessionsTable> {
  $$CountSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countType => $composableBuilder(
    column: $table.countType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countedBy => $composableBuilder(
    column: $table.countedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CountSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CountSessionsTable> {
  $$CountSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get countType =>
      $composableBuilder(column: $table.countType, builder: (column) => column);

  GeneratedColumn<String> get countedBy =>
      $composableBuilder(column: $table.countedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> countItemsRefs<T extends Object>(
    Expression<T> Function($$CountItemsTableAnnotationComposer a) f,
  ) {
    final $$CountItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.countItems,
      getReferencedColumn: (t) => t.countSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.countItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CountSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CountSessionsTable,
          CountSession,
          $$CountSessionsTableFilterComposer,
          $$CountSessionsTableOrderingComposer,
          $$CountSessionsTableAnnotationComposer,
          $$CountSessionsTableCreateCompanionBuilder,
          $$CountSessionsTableUpdateCompanionBuilder,
          (CountSession, $$CountSessionsTableReferences),
          CountSession,
          PrefetchHooks Function({bool countItemsRefs})
        > {
  $$CountSessionsTableTableManager(_$AppDatabase db, $CountSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CountSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CountSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CountSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> countType = const Value.absent(),
                Value<String?> countedBy = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountSessionsCompanion(
                id: id,
                countType: countType,
                countedBy: countedBy,
                startedAt: startedAt,
                completedAt: completedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String countType,
                Value<String?> countedBy = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountSessionsCompanion.insert(
                id: id,
                countType: countType,
                countedBy: countedBy,
                startedAt: startedAt,
                completedAt: completedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CountSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({countItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (countItemsRefs) db.countItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (countItemsRefs)
                    await $_getPrefetchedData<
                      CountSession,
                      $CountSessionsTable,
                      CountItem
                    >(
                      currentTable: table,
                      referencedTable: $$CountSessionsTableReferences
                          ._countItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CountSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).countItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.countSessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CountSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CountSessionsTable,
      CountSession,
      $$CountSessionsTableFilterComposer,
      $$CountSessionsTableOrderingComposer,
      $$CountSessionsTableAnnotationComposer,
      $$CountSessionsTableCreateCompanionBuilder,
      $$CountSessionsTableUpdateCompanionBuilder,
      (CountSession, $$CountSessionsTableReferences),
      CountSession,
      PrefetchHooks Function({bool countItemsRefs})
    >;
typedef $$CountItemsTableCreateCompanionBuilder =
    CountItemsCompanion Function({
      required String id,
      required String countSessionId,
      required String productId,
      required double expectedQuantity,
      required double actualQuantity,
      required double variance,
      Value<String?> varianceReason,
      Value<String?> notes,
      Value<DateTime> countedAt,
      Value<int> rowid,
    });
typedef $$CountItemsTableUpdateCompanionBuilder =
    CountItemsCompanion Function({
      Value<String> id,
      Value<String> countSessionId,
      Value<String> productId,
      Value<double> expectedQuantity,
      Value<double> actualQuantity,
      Value<double> variance,
      Value<String?> varianceReason,
      Value<String?> notes,
      Value<DateTime> countedAt,
      Value<int> rowid,
    });

final class $$CountItemsTableReferences
    extends BaseReferences<_$AppDatabase, $CountItemsTable, CountItem> {
  $$CountItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CountSessionsTable _countSessionIdTable(_$AppDatabase db) =>
      db.countSessions.createAlias(
        $_aliasNameGenerator(db.countItems.countSessionId, db.countSessions.id),
      );

  $$CountSessionsTableProcessedTableManager get countSessionId {
    final $_column = $_itemColumn<String>('count_session_id')!;

    final manager = $$CountSessionsTableTableManager(
      $_db,
      $_db.countSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_countSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.countItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CountItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CountItemsTable> {
  $$CountItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedQuantity => $composableBuilder(
    column: $table.expectedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get variance => $composableBuilder(
    column: $table.variance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get varianceReason => $composableBuilder(
    column: $table.varianceReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get countedAt => $composableBuilder(
    column: $table.countedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CountSessionsTableFilterComposer get countSessionId {
    final $$CountSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.countSessionId,
      referencedTable: $db.countSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountSessionsTableFilterComposer(
            $db: $db,
            $table: $db.countSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CountItemsTable> {
  $$CountItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedQuantity => $composableBuilder(
    column: $table.expectedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get variance => $composableBuilder(
    column: $table.variance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get varianceReason => $composableBuilder(
    column: $table.varianceReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get countedAt => $composableBuilder(
    column: $table.countedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CountSessionsTableOrderingComposer get countSessionId {
    final $$CountSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.countSessionId,
      referencedTable: $db.countSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.countSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CountItemsTable> {
  $$CountItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get expectedQuantity => $composableBuilder(
    column: $table.expectedQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get variance =>
      $composableBuilder(column: $table.variance, builder: (column) => column);

  GeneratedColumn<String> get varianceReason => $composableBuilder(
    column: $table.varianceReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get countedAt =>
      $composableBuilder(column: $table.countedAt, builder: (column) => column);

  $$CountSessionsTableAnnotationComposer get countSessionId {
    final $$CountSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.countSessionId,
      referencedTable: $db.countSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CountSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.countSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CountItemsTable,
          CountItem,
          $$CountItemsTableFilterComposer,
          $$CountItemsTableOrderingComposer,
          $$CountItemsTableAnnotationComposer,
          $$CountItemsTableCreateCompanionBuilder,
          $$CountItemsTableUpdateCompanionBuilder,
          (CountItem, $$CountItemsTableReferences),
          CountItem,
          PrefetchHooks Function({bool countSessionId, bool productId})
        > {
  $$CountItemsTableTableManager(_$AppDatabase db, $CountItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CountItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CountItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CountItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> countSessionId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double> expectedQuantity = const Value.absent(),
                Value<double> actualQuantity = const Value.absent(),
                Value<double> variance = const Value.absent(),
                Value<String?> varianceReason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> countedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountItemsCompanion(
                id: id,
                countSessionId: countSessionId,
                productId: productId,
                expectedQuantity: expectedQuantity,
                actualQuantity: actualQuantity,
                variance: variance,
                varianceReason: varianceReason,
                notes: notes,
                countedAt: countedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String countSessionId,
                required String productId,
                required double expectedQuantity,
                required double actualQuantity,
                required double variance,
                Value<String?> varianceReason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> countedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountItemsCompanion.insert(
                id: id,
                countSessionId: countSessionId,
                productId: productId,
                expectedQuantity: expectedQuantity,
                actualQuantity: actualQuantity,
                variance: variance,
                varianceReason: varianceReason,
                notes: notes,
                countedAt: countedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CountItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({countSessionId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (countSessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.countSessionId,
                                referencedTable: $$CountItemsTableReferences
                                    ._countSessionIdTable(db),
                                referencedColumn: $$CountItemsTableReferences
                                    ._countSessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$CountItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$CountItemsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CountItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CountItemsTable,
      CountItem,
      $$CountItemsTableFilterComposer,
      $$CountItemsTableOrderingComposer,
      $$CountItemsTableAnnotationComposer,
      $$CountItemsTableCreateCompanionBuilder,
      $$CountItemsTableUpdateCompanionBuilder,
      (CountItem, $$CountItemsTableReferences),
      CountItem,
      PrefetchHooks Function({bool countSessionId, bool productId})
    >;
typedef $$AlertsTableCreateCompanionBuilder =
    AlertsCompanion Function({
      required String id,
      Value<String?> productId,
      required String alertType,
      required String severity,
      required String message,
      Value<String> status,
      Value<DateTime> triggeredAt,
      Value<DateTime?> acknowledgedAt,
      Value<DateTime?> resolvedAt,
      Value<DateTime?> snoozeUntil,
      Value<int> rowid,
    });
typedef $$AlertsTableUpdateCompanionBuilder =
    AlertsCompanion Function({
      Value<String> id,
      Value<String?> productId,
      Value<String> alertType,
      Value<String> severity,
      Value<String> message,
      Value<String> status,
      Value<DateTime> triggeredAt,
      Value<DateTime?> acknowledgedAt,
      Value<DateTime?> resolvedAt,
      Value<DateTime?> snoozeUntil,
      Value<int> rowid,
    });

final class $$AlertsTableReferences
    extends BaseReferences<_$AppDatabase, $AlertsTable, Alert> {
  $$AlertsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) => db.products
      .createAlias($_aliasNameGenerator(db.alerts.productId, db.products.id));

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<String>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AlertsTableFilterComposer
    extends Composer<_$AppDatabase, $AlertsTable> {
  $$AlertsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get triggeredAt => $composableBuilder(
    column: $table.triggeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snoozeUntil => $composableBuilder(
    column: $table.snoozeUntil,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlertsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlertsTable> {
  $$AlertsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get triggeredAt => $composableBuilder(
    column: $table.triggeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozeUntil => $composableBuilder(
    column: $table.snoozeUntil,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlertsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlertsTable> {
  $$AlertsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alertType =>
      $composableBuilder(column: $table.alertType, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get triggeredAt => $composableBuilder(
    column: $table.triggeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get snoozeUntil => $composableBuilder(
    column: $table.snoozeUntil,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlertsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlertsTable,
          Alert,
          $$AlertsTableFilterComposer,
          $$AlertsTableOrderingComposer,
          $$AlertsTableAnnotationComposer,
          $$AlertsTableCreateCompanionBuilder,
          $$AlertsTableUpdateCompanionBuilder,
          (Alert, $$AlertsTableReferences),
          Alert,
          PrefetchHooks Function({bool productId})
        > {
  $$AlertsTableTableManager(_$AppDatabase db, $AlertsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlertsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlertsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlertsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> alertType = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> triggeredAt = const Value.absent(),
                Value<DateTime?> acknowledgedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<DateTime?> snoozeUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlertsCompanion(
                id: id,
                productId: productId,
                alertType: alertType,
                severity: severity,
                message: message,
                status: status,
                triggeredAt: triggeredAt,
                acknowledgedAt: acknowledgedAt,
                resolvedAt: resolvedAt,
                snoozeUntil: snoozeUntil,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> productId = const Value.absent(),
                required String alertType,
                required String severity,
                required String message,
                Value<String> status = const Value.absent(),
                Value<DateTime> triggeredAt = const Value.absent(),
                Value<DateTime?> acknowledgedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<DateTime?> snoozeUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlertsCompanion.insert(
                id: id,
                productId: productId,
                alertType: alertType,
                severity: severity,
                message: message,
                status: status,
                triggeredAt: triggeredAt,
                acknowledgedAt: acknowledgedAt,
                resolvedAt: resolvedAt,
                snoozeUntil: snoozeUntil,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AlertsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$AlertsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$AlertsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AlertsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlertsTable,
      Alert,
      $$AlertsTableFilterComposer,
      $$AlertsTableOrderingComposer,
      $$AlertsTableAnnotationComposer,
      $$AlertsTableCreateCompanionBuilder,
      $$AlertsTableUpdateCompanionBuilder,
      (Alert, $$AlertsTableReferences),
      Alert,
      PrefetchHooks Function({bool productId})
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String displayName,
      required String role,
      required String pin,
      Value<String?> email,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<String> role,
      Value<String> pin,
      Value<String?> email,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pin =>
      $composableBuilder(column: $table.pin, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> pin = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                displayName: displayName,
                role: role,
                pin: pin,
                email: email,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                required String role,
                required String pin,
                Value<String?> email = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                displayName: displayName,
                role: role,
                pin: pin,
                email: email,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$AuditLogTableCreateCompanionBuilder =
    AuditLogCompanion Function({
      required String id,
      Value<String?> performedBy,
      required String actionType,
      required String targetType,
      required String targetId,
      Value<String?> beforeSnapshot,
      Value<String?> afterSnapshot,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });
typedef $$AuditLogTableUpdateCompanionBuilder =
    AuditLogCompanion Function({
      Value<String> id,
      Value<String?> performedBy,
      Value<String> actionType,
      Value<String> targetType,
      Value<String> targetId,
      Value<String?> beforeSnapshot,
      Value<String?> afterSnapshot,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });

class $$AuditLogTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get performedBy => $composableBuilder(
    column: $table.performedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beforeSnapshot => $composableBuilder(
    column: $table.beforeSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get afterSnapshot => $composableBuilder(
    column: $table.afterSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get performedBy => $composableBuilder(
    column: $table.performedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beforeSnapshot => $composableBuilder(
    column: $table.beforeSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get afterSnapshot => $composableBuilder(
    column: $table.afterSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get performedBy => $composableBuilder(
    column: $table.performedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<String> get beforeSnapshot => $composableBuilder(
    column: $table.beforeSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get afterSnapshot => $composableBuilder(
    column: $table.afterSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$AuditLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogTable,
          AuditLogData,
          $$AuditLogTableFilterComposer,
          $$AuditLogTableOrderingComposer,
          $$AuditLogTableAnnotationComposer,
          $$AuditLogTableCreateCompanionBuilder,
          $$AuditLogTableUpdateCompanionBuilder,
          (
            AuditLogData,
            BaseReferences<_$AppDatabase, $AuditLogTable, AuditLogData>,
          ),
          AuditLogData,
          PrefetchHooks Function()
        > {
  $$AuditLogTableTableManager(_$AppDatabase db, $AuditLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> performedBy = const Value.absent(),
                Value<String> actionType = const Value.absent(),
                Value<String> targetType = const Value.absent(),
                Value<String> targetId = const Value.absent(),
                Value<String?> beforeSnapshot = const Value.absent(),
                Value<String?> afterSnapshot = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogCompanion(
                id: id,
                performedBy: performedBy,
                actionType: actionType,
                targetType: targetType,
                targetId: targetId,
                beforeSnapshot: beforeSnapshot,
                afterSnapshot: afterSnapshot,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> performedBy = const Value.absent(),
                required String actionType,
                required String targetType,
                required String targetId,
                Value<String?> beforeSnapshot = const Value.absent(),
                Value<String?> afterSnapshot = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogCompanion.insert(
                id: id,
                performedBy: performedBy,
                actionType: actionType,
                targetType: targetType,
                targetId: targetId,
                beforeSnapshot: beforeSnapshot,
                afterSnapshot: afterSnapshot,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogTable,
      AuditLogData,
      $$AuditLogTableFilterComposer,
      $$AuditLogTableOrderingComposer,
      $$AuditLogTableAnnotationComposer,
      $$AuditLogTableCreateCompanionBuilder,
      $$AuditLogTableUpdateCompanionBuilder,
      (
        AuditLogData,
        BaseReferences<_$AppDatabase, $AuditLogTable, AuditLogData>,
      ),
      AuditLogData,
      PrefetchHooks Function()
    >;
typedef $$CountDraftsTableCreateCompanionBuilder =
    CountDraftsCompanion Function({
      required String productId,
      required double actualQuantity,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CountDraftsTableUpdateCompanionBuilder =
    CountDraftsCompanion Function({
      Value<String> productId,
      Value<double> actualQuantity,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CountDraftsTableReferences
    extends BaseReferences<_$AppDatabase, $CountDraftsTable, CountDraft> {
  $$CountDraftsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.countDrafts.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CountDraftsTableFilterComposer
    extends Composer<_$AppDatabase, $CountDraftsTable> {
  $$CountDraftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountDraftsTableOrderingComposer
    extends Composer<_$AppDatabase, $CountDraftsTable> {
  $$CountDraftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountDraftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CountDraftsTable> {
  $$CountDraftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get actualQuantity => $composableBuilder(
    column: $table.actualQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CountDraftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CountDraftsTable,
          CountDraft,
          $$CountDraftsTableFilterComposer,
          $$CountDraftsTableOrderingComposer,
          $$CountDraftsTableAnnotationComposer,
          $$CountDraftsTableCreateCompanionBuilder,
          $$CountDraftsTableUpdateCompanionBuilder,
          (CountDraft, $$CountDraftsTableReferences),
          CountDraft,
          PrefetchHooks Function({bool productId})
        > {
  $$CountDraftsTableTableManager(_$AppDatabase db, $CountDraftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CountDraftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CountDraftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CountDraftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<double> actualQuantity = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountDraftsCompanion(
                productId: productId,
                actualQuantity: actualQuantity,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                required double actualQuantity,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountDraftsCompanion.insert(
                productId: productId,
                actualQuantity: actualQuantity,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CountDraftsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$CountDraftsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$CountDraftsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CountDraftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CountDraftsTable,
      CountDraft,
      $$CountDraftsTableFilterComposer,
      $$CountDraftsTableOrderingComposer,
      $$CountDraftsTableAnnotationComposer,
      $$CountDraftsTableCreateCompanionBuilder,
      $$CountDraftsTableUpdateCompanionBuilder,
      (CountDraft, $$CountDraftsTableReferences),
      CountDraft,
      PrefetchHooks Function({bool productId})
    >;
typedef $$SalesTransactionsTableCreateCompanionBuilder =
    SalesTransactionsCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      required double totalAmount,
      required String itemsSnapshot,
      Value<String> paymentMethod,
      Value<int?> shiftId,
    });
typedef $$SalesTransactionsTableUpdateCompanionBuilder =
    SalesTransactionsCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      Value<double> totalAmount,
      Value<String> itemsSnapshot,
      Value<String> paymentMethod,
      Value<int?> shiftId,
    });

class $$SalesTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesTransactionsTable> {
  $$SalesTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsSnapshot => $composableBuilder(
    column: $table.itemsSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTransactionsTable> {
  $$SalesTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsSnapshot => $composableBuilder(
    column: $table.itemsSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTransactionsTable> {
  $$SalesTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemsSnapshot => $composableBuilder(
    column: $table.itemsSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);
}

class $$SalesTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTransactionsTable,
          SalesTransaction,
          $$SalesTransactionsTableFilterComposer,
          $$SalesTransactionsTableOrderingComposer,
          $$SalesTransactionsTableAnnotationComposer,
          $$SalesTransactionsTableCreateCompanionBuilder,
          $$SalesTransactionsTableUpdateCompanionBuilder,
          (
            SalesTransaction,
            BaseReferences<
              _$AppDatabase,
              $SalesTransactionsTable,
              SalesTransaction
            >,
          ),
          SalesTransaction,
          PrefetchHooks Function()
        > {
  $$SalesTransactionsTableTableManager(
    _$AppDatabase db,
    $SalesTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> itemsSnapshot = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
              }) => SalesTransactionsCompanion(
                id: id,
                timestamp: timestamp,
                totalAmount: totalAmount,
                itemsSnapshot: itemsSnapshot,
                paymentMethod: paymentMethod,
                shiftId: shiftId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                required double totalAmount,
                required String itemsSnapshot,
                Value<String> paymentMethod = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
              }) => SalesTransactionsCompanion.insert(
                id: id,
                timestamp: timestamp,
                totalAmount: totalAmount,
                itemsSnapshot: itemsSnapshot,
                paymentMethod: paymentMethod,
                shiftId: shiftId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTransactionsTable,
      SalesTransaction,
      $$SalesTransactionsTableFilterComposer,
      $$SalesTransactionsTableOrderingComposer,
      $$SalesTransactionsTableAnnotationComposer,
      $$SalesTransactionsTableCreateCompanionBuilder,
      $$SalesTransactionsTableUpdateCompanionBuilder,
      (
        SalesTransaction,
        BaseReferences<
          _$AppDatabase,
          $SalesTransactionsTable,
          SalesTransaction
        >,
      ),
      SalesTransaction,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      required String id,
      required String name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UtangLedgerTable, List<UtangLedgerData>>
  _utangLedgerRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utangLedger,
    aliasName: $_aliasNameGenerator(db.customers.id, db.utangLedger.customerId),
  );

  $$UtangLedgerTableProcessedTableManager get utangLedgerRefs {
    final manager = $$UtangLedgerTableTableManager(
      $_db,
      $_db.utangLedger,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_utangLedgerRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> utangLedgerRefs(
    Expression<bool> Function($$UtangLedgerTableFilterComposer f) f,
  ) {
    final $$UtangLedgerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utangLedger,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtangLedgerTableFilterComposer(
            $db: $db,
            $table: $db.utangLedger,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> utangLedgerRefs<T extends Object>(
    Expression<T> Function($$UtangLedgerTableAnnotationComposer a) f,
  ) {
    final $$UtangLedgerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utangLedger,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtangLedgerTableAnnotationComposer(
            $db: $db,
            $table: $db.utangLedger,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool utangLedgerRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({utangLedgerRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (utangLedgerRefs) db.utangLedger],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (utangLedgerRefs)
                    await $_getPrefetchedData<
                      Customer,
                      $CustomersTable,
                      UtangLedgerData
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._utangLedgerRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(
                            db,
                            table,
                            p0,
                          ).utangLedgerRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.customerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool utangLedgerRefs})
    >;
typedef $$UtangLedgerTableCreateCompanionBuilder =
    UtangLedgerCompanion Function({
      required String id,
      required String customerId,
      required double amount,
      Value<DateTime> timestamp,
      Value<String?> description,
      Value<int?> shiftId,
      Value<String?> itemsSnapshot,
      Value<int> rowid,
    });
typedef $$UtangLedgerTableUpdateCompanionBuilder =
    UtangLedgerCompanion Function({
      Value<String> id,
      Value<String> customerId,
      Value<double> amount,
      Value<DateTime> timestamp,
      Value<String?> description,
      Value<int?> shiftId,
      Value<String?> itemsSnapshot,
      Value<int> rowid,
    });

final class $$UtangLedgerTableReferences
    extends BaseReferences<_$AppDatabase, $UtangLedgerTable, UtangLedgerData> {
  $$UtangLedgerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.utangLedger.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<String>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UtangLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $UtangLedgerTable> {
  $$UtangLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsSnapshot => $composableBuilder(
    column: $table.itemsSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtangLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $UtangLedgerTable> {
  $$UtangLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsSnapshot => $composableBuilder(
    column: $table.itemsSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtangLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtangLedgerTable> {
  $$UtangLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<String> get itemsSnapshot => $composableBuilder(
    column: $table.itemsSnapshot,
    builder: (column) => column,
  );

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtangLedgerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtangLedgerTable,
          UtangLedgerData,
          $$UtangLedgerTableFilterComposer,
          $$UtangLedgerTableOrderingComposer,
          $$UtangLedgerTableAnnotationComposer,
          $$UtangLedgerTableCreateCompanionBuilder,
          $$UtangLedgerTableUpdateCompanionBuilder,
          (UtangLedgerData, $$UtangLedgerTableReferences),
          UtangLedgerData,
          PrefetchHooks Function({bool customerId})
        > {
  $$UtangLedgerTableTableManager(_$AppDatabase db, $UtangLedgerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtangLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtangLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtangLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
                Value<String?> itemsSnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtangLedgerCompanion(
                id: id,
                customerId: customerId,
                amount: amount,
                timestamp: timestamp,
                description: description,
                shiftId: shiftId,
                itemsSnapshot: itemsSnapshot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String customerId,
                required double amount,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
                Value<String?> itemsSnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtangLedgerCompanion.insert(
                id: id,
                customerId: customerId,
                amount: amount,
                timestamp: timestamp,
                description: description,
                shiftId: shiftId,
                itemsSnapshot: itemsSnapshot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UtangLedgerTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$UtangLedgerTableReferences
                                    ._customerIdTable(db),
                                referencedColumn: $$UtangLedgerTableReferences
                                    ._customerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UtangLedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtangLedgerTable,
      UtangLedgerData,
      $$UtangLedgerTableFilterComposer,
      $$UtangLedgerTableOrderingComposer,
      $$UtangLedgerTableAnnotationComposer,
      $$UtangLedgerTableCreateCompanionBuilder,
      $$UtangLedgerTableUpdateCompanionBuilder,
      (UtangLedgerData, $$UtangLedgerTableReferences),
      UtangLedgerData,
      PrefetchHooks Function({bool customerId})
    >;
typedef $$StoreExpensesTableCreateCompanionBuilder =
    StoreExpensesCompanion Function({
      Value<int> id,
      required double amount,
      required String description,
      Value<DateTime> timestamp,
      Value<int?> shiftId,
    });
typedef $$StoreExpensesTableUpdateCompanionBuilder =
    StoreExpensesCompanion Function({
      Value<int> id,
      Value<double> amount,
      Value<String> description,
      Value<DateTime> timestamp,
      Value<int?> shiftId,
    });

class $$StoreExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $StoreExpensesTable> {
  $$StoreExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoreExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoreExpensesTable> {
  $$StoreExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoreExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoreExpensesTable> {
  $$StoreExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);
}

class $$StoreExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoreExpensesTable,
          StoreExpense,
          $$StoreExpensesTableFilterComposer,
          $$StoreExpensesTableOrderingComposer,
          $$StoreExpensesTableAnnotationComposer,
          $$StoreExpensesTableCreateCompanionBuilder,
          $$StoreExpensesTableUpdateCompanionBuilder,
          (
            StoreExpense,
            BaseReferences<_$AppDatabase, $StoreExpensesTable, StoreExpense>,
          ),
          StoreExpense,
          PrefetchHooks Function()
        > {
  $$StoreExpensesTableTableManager(_$AppDatabase db, $StoreExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoreExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoreExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoreExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
              }) => StoreExpensesCompanion(
                id: id,
                amount: amount,
                description: description,
                timestamp: timestamp,
                shiftId: shiftId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double amount,
                required String description,
                Value<DateTime> timestamp = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
              }) => StoreExpensesCompanion.insert(
                id: id,
                amount: amount,
                description: description,
                timestamp: timestamp,
                shiftId: shiftId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoreExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoreExpensesTable,
      StoreExpense,
      $$StoreExpensesTableFilterComposer,
      $$StoreExpensesTableOrderingComposer,
      $$StoreExpensesTableAnnotationComposer,
      $$StoreExpensesTableCreateCompanionBuilder,
      $$StoreExpensesTableUpdateCompanionBuilder,
      (
        StoreExpense,
        BaseReferences<_$AppDatabase, $StoreExpensesTable, StoreExpense>,
      ),
      StoreExpense,
      PrefetchHooks Function()
    >;
typedef $$CashierShiftsTableCreateCompanionBuilder =
    CashierShiftsCompanion Function({
      Value<int> id,
      required String cashierName,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      required double openingFloat,
      Value<double?> expectedClosingFloat,
      Value<double?> actualClosingFloat,
      Value<double?> variance,
    });
typedef $$CashierShiftsTableUpdateCompanionBuilder =
    CashierShiftsCompanion Function({
      Value<int> id,
      Value<String> cashierName,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<double> openingFloat,
      Value<double?> expectedClosingFloat,
      Value<double?> actualClosingFloat,
      Value<double?> variance,
    });

class $$CashierShiftsTableFilterComposer
    extends Composer<_$AppDatabase, $CashierShiftsTable> {
  $$CashierShiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cashierName => $composableBuilder(
    column: $table.cashierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get openingFloat => $composableBuilder(
    column: $table.openingFloat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedClosingFloat => $composableBuilder(
    column: $table.expectedClosingFloat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualClosingFloat => $composableBuilder(
    column: $table.actualClosingFloat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get variance => $composableBuilder(
    column: $table.variance,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashierShiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashierShiftsTable> {
  $$CashierShiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cashierName => $composableBuilder(
    column: $table.cashierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get openingFloat => $composableBuilder(
    column: $table.openingFloat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedClosingFloat => $composableBuilder(
    column: $table.expectedClosingFloat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualClosingFloat => $composableBuilder(
    column: $table.actualClosingFloat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get variance => $composableBuilder(
    column: $table.variance,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashierShiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashierShiftsTable> {
  $$CashierShiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cashierName => $composableBuilder(
    column: $table.cashierName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<double> get openingFloat => $composableBuilder(
    column: $table.openingFloat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get expectedClosingFloat => $composableBuilder(
    column: $table.expectedClosingFloat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualClosingFloat => $composableBuilder(
    column: $table.actualClosingFloat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get variance =>
      $composableBuilder(column: $table.variance, builder: (column) => column);
}

class $$CashierShiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashierShiftsTable,
          CashierShift,
          $$CashierShiftsTableFilterComposer,
          $$CashierShiftsTableOrderingComposer,
          $$CashierShiftsTableAnnotationComposer,
          $$CashierShiftsTableCreateCompanionBuilder,
          $$CashierShiftsTableUpdateCompanionBuilder,
          (
            CashierShift,
            BaseReferences<_$AppDatabase, $CashierShiftsTable, CashierShift>,
          ),
          CashierShift,
          PrefetchHooks Function()
        > {
  $$CashierShiftsTableTableManager(_$AppDatabase db, $CashierShiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashierShiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashierShiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashierShiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cashierName = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<double> openingFloat = const Value.absent(),
                Value<double?> expectedClosingFloat = const Value.absent(),
                Value<double?> actualClosingFloat = const Value.absent(),
                Value<double?> variance = const Value.absent(),
              }) => CashierShiftsCompanion(
                id: id,
                cashierName: cashierName,
                startTime: startTime,
                endTime: endTime,
                openingFloat: openingFloat,
                expectedClosingFloat: expectedClosingFloat,
                actualClosingFloat: actualClosingFloat,
                variance: variance,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cashierName,
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                required double openingFloat,
                Value<double?> expectedClosingFloat = const Value.absent(),
                Value<double?> actualClosingFloat = const Value.absent(),
                Value<double?> variance = const Value.absent(),
              }) => CashierShiftsCompanion.insert(
                id: id,
                cashierName: cashierName,
                startTime: startTime,
                endTime: endTime,
                openingFloat: openingFloat,
                expectedClosingFloat: expectedClosingFloat,
                actualClosingFloat: actualClosingFloat,
                variance: variance,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashierShiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashierShiftsTable,
      CashierShift,
      $$CashierShiftsTableFilterComposer,
      $$CashierShiftsTableOrderingComposer,
      $$CashierShiftsTableAnnotationComposer,
      $$CashierShiftsTableCreateCompanionBuilder,
      $$CashierShiftsTableUpdateCompanionBuilder,
      (
        CashierShift,
        BaseReferences<_$AppDatabase, $CashierShiftsTable, CashierShift>,
      ),
      CashierShift,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$StockInEventsTableTableManager get stockInEvents =>
      $$StockInEventsTableTableManager(_db, _db.stockInEvents);
  $$StockInItemsTableTableManager get stockInItems =>
      $$StockInItemsTableTableManager(_db, _db.stockInItems);
  $$CountSessionsTableTableManager get countSessions =>
      $$CountSessionsTableTableManager(_db, _db.countSessions);
  $$CountItemsTableTableManager get countItems =>
      $$CountItemsTableTableManager(_db, _db.countItems);
  $$AlertsTableTableManager get alerts =>
      $$AlertsTableTableManager(_db, _db.alerts);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$AuditLogTableTableManager get auditLog =>
      $$AuditLogTableTableManager(_db, _db.auditLog);
  $$CountDraftsTableTableManager get countDrafts =>
      $$CountDraftsTableTableManager(_db, _db.countDrafts);
  $$SalesTransactionsTableTableManager get salesTransactions =>
      $$SalesTransactionsTableTableManager(_db, _db.salesTransactions);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$UtangLedgerTableTableManager get utangLedger =>
      $$UtangLedgerTableTableManager(_db, _db.utangLedger);
  $$StoreExpensesTableTableManager get storeExpenses =>
      $$StoreExpensesTableTableManager(_db, _db.storeExpenses);
  $$CashierShiftsTableTableManager get cashierShifts =>
      $$CashierShiftsTableTableManager(_db, _db.cashierShifts);
}
