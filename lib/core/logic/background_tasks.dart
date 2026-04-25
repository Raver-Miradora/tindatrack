import 'package:workmanager/workmanager.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';
import 'burn_rate_engine.dart';

const String inventoryAuditTask = "com.tindatrack.inventory_audit";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == inventoryAuditTask) {
      final db = AppDatabase();
      final engine = BurnRateEngine(db);
      
      try {
        await engine.updateAll();
        
        // Log background success heartbeat
        await db.into(db.auditLog).insert(
          AuditLogCompanion.insert(
            id: const Uuid().v4(),
            actionType: 'System Heartbeat',
            targetType: 'background_task',
            targetId: 'burn_rate_engine',
            afterSnapshot: const drift.Value('{"status": "success"}'),
            timestamp: drift.Value(DateTime.now()),
          ),
        );

        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      } finally {
        await db.close();
      }
    }
    return Future.value(true);
  });
}

class BackgroundTaskService {
  static Future<void> init() async {
    await Workmanager().initialize(
      callbackDispatcher,
    );
  }

  static Future<void> scheduleDailyAudit() async {
    await Workmanager().registerPeriodicTask(
      "daily-audit",
      inventoryAuditTask,
      frequency: const Duration(hours: 24),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      constraints: Constraints(
        requiresBatteryNotLow: true,
      ),
    );
  }
}
