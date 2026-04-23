import 'dart:convert';
import '../../core/database/database.dart';

class LogParser {
  static String getSummary(AuditLogData log) {
    if (log.afterSnapshot == null) return _formatActionType(log.actionType);

    try {
      final Map<String, dynamic> data = jsonDecode(log.afterSnapshot!);
      
      switch (log.actionType) {
        case 'New Delivery':
          final int count = data['itemCount'] ?? 0;
          final String supplier = data['supplier'] ?? 'General Supplier';
          return 'Received delivery from $supplier ($count items)';
          
        case 'Count Discrepancy':
          final double actual = (data['actual'] as num?)?.toDouble() ?? 0.0;
          final double variance = (data['variance'] as num?)?.toDouble() ?? 0.0;
          final String direction = variance > 0 ? 'lost' : 'found';
          return 'Physical count: ${actual.toInt()} (${variance.abs().toInt()} $direction)';

        case 'Inventory Adjusted':
           return 'System stock reconciliation';
           
        default:
          return _formatActionType(log.actionType);
      }
    } catch (e) {
      return _formatActionType(log.actionType);
    }
  }

  static String _formatActionType(String type) {
    return type.replaceAll('_', ' ');
  }
}
