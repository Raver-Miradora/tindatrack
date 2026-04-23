import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'database.dart';

Future<void> seedDatabase(AppDatabase db) async {
  final count = await db.select(db.products).get();
  if (count.isNotEmpty) return;

  const uuid = Uuid();
  final now = DateTime.now();

  final List<ProductsCompanion> seeds = [
    // Beverages
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Coca-Cola 290ml',
      category: 'Beverages',
      unit: 'bottle',
      barcode: const Value('5449000000996'),
      reorderPoint: 24,
      currentStock: const Value(48),
      averageCost: const Value(15.0),
      averageSellingPrice: const Value(20.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Nescafe Stick',
      category: 'Beverages',
      unit: 'sachet',
      barcode: const Value('4800361305018'),
      reorderPoint: 50,
      currentStock: const Value(120),
      averageCost: const Value(6.0),
      averageSellingPrice: const Value(10.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Bear Brand 33g',
      category: 'Beverages',
      unit: 'sachet',
      barcode: const Value('4800361361533'),
      reorderPoint: 20,
      currentStock: const Value(60),
      averageCost: const Value(12.0),
      averageSellingPrice: const Value(16.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Milo 22g',
      category: 'Beverages',
      unit: 'sachet',
      barcode: const Value('4800361324118'),
      reorderPoint: 30,
      currentStock: const Value(80),
      averageCost: const Value(10.0),
      averageSellingPrice: const Value(14.0),
    ),
    
    // Canned Goods
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: '555 Sardines Tomato',
      category: 'Canned Goods',
      unit: 'can',
      barcode: const Value('4800016010023'),
      reorderPoint: 12,
      currentStock: const Value(24),
      averageCost: const Value(18.0),
      averageSellingPrice: const Value(22.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Century Tuna Flakes Oil 155g',
      category: 'Canned Goods',
      unit: 'can',
      barcode: const Value('4800016641555'),
      reorderPoint: 10,
      currentStock: const Value(15),
      averageCost: const Value(35.0),
      averageSellingPrice: const Value(42.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Argentina Corned Beef 150g',
      category: 'Canned Goods',
      unit: 'can',
      barcode: const Value('4800016101509'),
      reorderPoint: 15,
      currentStock: const Value(20),
      averageCost: const Value(38.0),
      averageSellingPrice: const Value(45.0),
    ),

    // Snacks
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Skyflakes 10s',
      category: 'Snacks',
      unit: 'pack',
      barcode: const Value('4800045101013'),
      reorderPoint: 10,
      currentStock: const Value(25),
      averageCost: const Value(45.0),
      averageSellingPrice: const Value(55.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Piattos Cheese 40g',
      category: 'Snacks',
      unit: 'pack',
      barcode: const Value('4800016603034'),
      reorderPoint: 20,
      currentStock: const Value(30),
      averageCost: const Value(12.0),
      averageSellingPrice: const Value(16.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Nova Multigrain 40g',
      category: 'Snacks',
      unit: 'pack',
      barcode: const Value('4800016604048'),
      reorderPoint: 15,
      currentStock: const Value(20),
      averageCost: const Value(13.0),
      averageSellingPrice: const Value(18.0),
    ),

    // Personal Care
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Pantisne Shampoo 12ml',
      category: 'Personal Care',
      unit: 'sachet',
      barcode: const Value('4902430882149'),
      reorderPoint: 24,
      currentStock: const Value(48),
      averageCost: const Value(5.5),
      averageSellingPrice: const Value(8.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Sunlight Soap Sachet',
      category: 'Personal Care',
      unit: 'sachet',
      barcode: const Value('4800067890123'),
      reorderPoint: 12,
      currentStock: const Value(24),
      averageCost: const Value(6.0),
      averageSellingPrice: const Value(10.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'SafeGuard White 60g',
      category: 'Personal Care',
      unit: 'pcs',
      barcode: const Value('4902430412345'),
      reorderPoint: 10,
      currentStock: const Value(12),
      averageCost: const Value(22.0),
      averageSellingPrice: const Value(28.0),
    ),

    // Condiments & Pantry
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Silver Swan Soy Sauce 200ml',
      category: 'Condiments',
      unit: 'pack',
      barcode: const Value('4800011122233'),
      reorderPoint: 12,
      currentStock: const Value(15),
      averageCost: const Value(10.0),
      averageSellingPrice: const Value(14.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Datu Puti Vinegar 200ml',
      category: 'Condiments',
      unit: 'pack',
      barcode: const Value('4800011122244'),
      reorderPoint: 12,
      currentStock: const Value(15),
      averageCost: const Value(9.0),
      averageSellingPrice: const Value(13.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Magic Sarap 8g',
      category: 'Condiments',
      unit: 'sachet',
      barcode: const Value('4800361345678'),
      reorderPoint: 50,
      currentStock: const Value(100),
      averageCost: const Value(3.5),
      averageSellingPrice: const Value(5.0),
    ),
    
    // Household
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Tide Powder Sachet',
      category: 'Household',
      unit: 'sachet',
      barcode: const Value('4902430999999'),
      reorderPoint: 48,
      currentStock: const Value(72),
      averageCost: const Value(7.0),
      averageSellingPrice: const Value(11.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Surf Fabcon Sachet',
      category: 'Household',
      unit: 'sachet',
      barcode: const Value('4800067123456'),
      reorderPoint: 36,
      currentStock: const Value(60),
      averageCost: const Value(5.5),
      averageSellingPrice: const Value(9.0),
    ),

    // More Alcohol & Cigarettes (Common in Sari-sari)
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'San Miguel Pale Pilsen 320ml',
      category: 'Alcohol',
      unit: 'bottle',
      barcode: const Value('4800057011010'),
      reorderPoint: 24,
      currentStock: const Value(36),
      averageCost: const Value(35.0),
      averageSellingPrice: const Value(45.0),
    ),
    ProductsCompanion.insert(
      id: uuid.v4(),
      name: 'Red Horse Stallion 330ml',
      category: 'Alcohol',
      unit: 'bottle',
      barcode: const Value('4800057011027'),
      reorderPoint: 24,
      currentStock: const Value(36),
      averageCost: const Value(38.0),
      averageSellingPrice: const Value(48.0),
    ),
  ];

  await db.batch((batch) {
    batch.insertAll(db.products, seeds);
  });

  // Seed initial Audit Log
  await db.into(db.auditLog).insert(
    AuditLogCompanion.insert(
      id: uuid.v4(),
      actionType: 'System Setup',
      targetType: 'database',
      targetId: 'initial_seed',
      timestamp: Value(now),
    ),
  );
}
