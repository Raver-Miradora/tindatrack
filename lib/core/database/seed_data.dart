import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'database.dart';

class DatabaseSeeder {
  static Future<void> seedInitialData(AppDatabase db) async {
    // Check if products already exist to avoid double seeding
    final results = await db.select(db.products).get();
    if (results.isNotEmpty) return;

    final baseProducts = [
      _product('Nescafe Original Twin Pack', 'Beverages', 'pack', 25.0, 15),
      _product('Marlboro Red (Pack)', 'Tobacco', 'pack', 150.0, 5),
      _product('Lucky Me Pancit Canton Original', 'Noodles', 'piece', 18.0, 20),
      _product('Coca-Cola 1.5L', 'Beverages', 'bottle', 75.0, 10),
      _product('Coca-Cola Mismo', 'Beverages', 'bottle', 20.0, 15),
      _product('Bear Brand Powdered Milk 33g', 'Dairy', 'sachet', 15.0, 20),
      _product('Kopiko Brown Twin Pack', 'Beverages', 'pack', 25.0, 15),
      _product('Magic Flakes Crackers', 'Snacks', 'pack', 8.0, 30),
      _product('SkyFlakes Crackers', 'Snacks', 'pack', 8.0, 30),
      _product('Datu Puti Vinegar 200ml', 'Condiments', 'pouch', 15.0, 10),
      _product('Datu Puti Soy Sauce 200ml', 'Condiments', 'pouch', 15.0, 10),
      _product('Silver Swan Soy Sauce 200ml', 'Condiments', 'pouch', 15.0, 10),
      _product('Mang Tomas All-Around Sarsa', 'Condiments', 'bottle', 35.0, 5),
      _product('UFC Banana Ketchup', 'Condiments', 'pouch', 20.0, 10),
      _product('San Miguel Pale Pilsen', 'Alcohol', 'bottle', 50.0, 12),
      _product('Red Horse Extra Strong', 'Alcohol', 'bottle', 65.0, 12),
      _product('Emperador Light 750ml', 'Alcohol', 'bottle', 140.0, 3),
      _product('Ginebra San Miguel 350ml', 'Alcohol', 'bottle', 70.0, 5),
      _product('Surf Powder Cherry Blossom 65g', 'Laundry', 'sachet', 12.0, 20),
      _product('Ariel Powder Sunrise Fresh 70g', 'Laundry', 'sachet', 15.0, 20),
      _product('Champion Detergent Bar', 'Laundry', 'piece', 20.0, 10),
      _product('Palmolive Naturals Shampoo', 'Personal Care', 'sachet', 7.0, 30),
      _product('Sunsilk Smooth & Manageable', 'Personal Care', 'sachet', 7.0, 30),
      _product('Creamsilk Standout Straight', 'Personal Care', 'sachet', 7.0, 30),
      _product('Safeguard Pure White Soap 60g', 'Personal Care', 'piece', 25.0, 10),
      _product('Rexona Men Ice Cool Sachet', 'Personal Care', 'sachet', 15.0, 15),
      _product('Modess Cottony Soft Regular', 'Personal Care', 'pack', 35.0, 10),
      _product('Pampers Baby Dry Taped S', 'Diapers', 'piece', 12.0, 30),
      _product('EQ Dry Diaper S', 'Diapers', 'piece', 9.0, 30),
      _product('C2 Classic Lemon 500ml', 'Beverages', 'bottle', 30.0, 10),
      _product('C2 Apple 500ml', 'Beverages', 'bottle', 30.0, 10),
      _product('Gatorade Blue Bolt 500ml', 'Beverages', 'bottle', 40.0, 5),
      _product('Sting Energy Drink 300ml', 'Beverages', 'bottle', 20.0, 10),
      _product('Cobra Energy Drink', 'Beverages', 'bottle', 20.0, 10),
      _product('Piattos Cheese', 'Snacks', 'pack', 18.0, 15),
      _product('Chippy BBQ', 'Snacks', 'pack', 18.0, 15),
      _product('Mr. Chips Nacho Cheese', 'Snacks', 'pack', 18.0, 15),
      _product('V-Cut Spicy BBQ', 'Snacks', 'pack', 18.0, 10),
      _product('Nova Multigrain Snacks', 'Snacks', 'pack', 18.0, 10),
      _product('Boy Bawang Garlic', 'Snacks', 'pack', 15.0, 20),
      _product('Rebisco Hansel Sandwich', 'Snacks', 'pack', 10.0, 20),
      _product('Fita Crackers', 'Snacks', 'pack', 10.0, 20),
      _product('Oreo Cookies Vanilla', 'Snacks', 'pack', 15.0, 20),
      _product('Great Taste White Twin Pack', 'Beverages', 'pack', 25.0, 15),
      _product('Energen Chocolate', 'Beverages', 'sachet', 15.0, 20),
      _product('Milo Everyday Sachet 24g', 'Beverages', 'sachet', 12.0, 20),
      _product('Lipton Yellow Label Tea', 'Beverages', 'piece', 10.0, 20),
      _product('Del Monte Fit n Right 330ml', 'Beverages', 'bottle', 35.0, 5),
      _product('Chuckie Chocolate Milk', 'Dairy', 'piece', 28.0, 10),
      _product('Fitnesse Cereal Bar', 'Snacks', 'piece', 20.0, 10),
    ];

    await db.batch((batch) {
      batch.insertAll(db.products, baseProducts);
    });
  }

  static ProductsCompanion _product(
    String name,
    String category,
    String unit,
    double cost,
    double reorder,
  ) {
    return ProductsCompanion.insert(
      id: const Uuid().v4(),
      name: name,
      category: category,
      unit: unit,
      averageCost: Value(cost),
      reorderPoint: reorder,
    );
  }
}
