import 'package:go_router/go_router.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/stock_in/new_delivery_screen.dart';
import '../features/count/count_list_screen.dart';
import '../features/count/new_count_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/reports/audit_log_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/inventory/product_create_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/stock-in',
      builder: (context, state) => const NewDeliveryScreen(),
    ),
    GoRoute(
      path: '/physical-count',
      builder: (context, state) => const CountListScreen(),
    ),
    GoRoute(
      path: '/physical-count/new',
      builder: (context, state) => const NewCountScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/audit-log',
      builder: (context, state) => const AuditLogScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/inventory/create',
      builder: (context, state) {
        final barcode = state.extra as String?;
        return ProductCreateScreen(initialBarcode: barcode);
      },
    ),
  ],
);
