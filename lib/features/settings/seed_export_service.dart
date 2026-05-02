import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/database/database.dart';

class SeedExportService {
  static Future<void> exportNewProductsForSeed(List<Product> products) async {
    final newProducts = products.where((p) => !p.isSeeded).toList();
    
    final exportData = newProducts.map((p) => {
      "barcode": p.barcode ?? "",
      "name": p.name,
      "category": p.category,
      "unit": p.unit,
      "cost": p.averageCost,
      "price": p.averageSellingPrice ?? 0.0,
    }).toList();

    const encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(exportData);
    final finalOutput = "// NEW SCANNED PRODUCTS FOR SEED DATA.\n$jsonString";

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/new_seed_data.txt');
    await file.writeAsString(finalOutput);

    // ignore: deprecated_member_use
    await Share.shareXFiles([XFile(file.path)], text: 'TindaTrack Seed Data Export');
  }
}
