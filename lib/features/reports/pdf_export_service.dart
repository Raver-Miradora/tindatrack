import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../../core/database/database.dart';

class PdfExportService {
  static Future<void> exportInventoryReport(List<Product> products, String storeName) async {
    final doc = pw.Document();
    
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);
    final now = DateTime.now();
    final dateFormat = DateFormat('MMMM dd, yyyy - hh:mm a');

    // Calculate totals
    double grandTotal = 0;
    for (var p in products) {
      if (p.currentStock > 0) {
        grandTotal += p.currentStock * (p.averageSellingPrice ?? 0);
      }
    }

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(storeName, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 4),
            pw.Text('TindaTrack - Ulat ng Imbentaryo', style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 4),
            pw.Text('Generated: ${dateFormat.format(now)}', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.SizedBox(height: 10),
          ]
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            context: context,
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            headerHeight: 30,
            cellHeight: 25,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
              4: pw.Alignment.centerRight,
            },
            headers: ['Product Name', 'Current Stock', 'Unit Cost', 'Selling Price', 'Total Value'],
            data: products.where((p) => p.currentStock > 0).map((p) {
              final val = p.currentStock * (p.averageSellingPrice ?? 0);
              return [
                p.name,
                p.currentStock.toInt().toString(),
                currencyFormat.format(p.averageCost),
                currencyFormat.format(p.averageSellingPrice ?? 0),
                currencyFormat.format(val),
              ];
            }).toList(),
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('Grand Total: ', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text(currencyFormat.format(grandTotal), style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            ],
          ),
        ],
      )
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: 'Inventory_Report_${now.millisecondsSinceEpoch}.pdf',
    );
  }
}
