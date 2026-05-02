import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/stock_in/new_delivery_screen.dart';
import '../features/count/count_list_screen.dart';
import '../features/count/new_count_screen.dart';

import '../features/reports/audit_log_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/inventory/product_list_screen.dart';
import '../features/inventory/product_create_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/pos/pos_scanner_screen.dart';
import '../features/sales_history/daily_transactions_screen.dart';
import '../features/sales_history/utang_list_screen.dart';
import '../features/analytics/analytics_dashboard_screen.dart';
import 'providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authProvider);
  final prefs = ref.watch(sharedPreferencesProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final pinSet = prefs.getString('owner_pin') != null;
      final loggingIn = state.matchedLocation == '/login';

      // FORCE SETUP: If no PIN is set, must go to login (setup mode)
      if (!pinSet && !loggingIn) {
        return '/login';
      }
      
      // GUARD: If PIN is set but not authenticated, must go to login
      if (pinSet && !isAuthenticated && !loggingIn) {
        return '/login';
      }

      // REDIRECT: If authenticated and on login, go home
      if (isAuthenticated && loggingIn) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/pos',
        builder: (context, state) => const PosScannerScreen(),
      ),
      GoRoute(
        path: '/sales-history',
        builder: (context, state) => const DailyTransactionsScreen(),
      ),
      GoRoute(
        path: '/utang-list',
        builder: (context, state) => const UtangListScreen(),
      ),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsDashboardScreen(),
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
        path: '/audit-log',
        builder: (context, state) => const AuditLogScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) {
          final showLowStock = state.extra as bool? ?? false;
          return ProductListScreen(initialShowLowStock: showLowStock);
        },
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
});
