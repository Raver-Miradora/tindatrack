import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/stock_in/new_delivery_screen.dart';
import '../features/count/count_list_screen.dart';
import '../features/count/new_count_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/reports/audit_log_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/inventory/product_list_screen.dart';
import '../features/inventory/product_create_screen.dart';
import '../features/auth/auth_screen.dart';
import 'providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authProvider);
  final prefs = ref.watch(sharedPreferencesProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final pinSet = prefs.getString('owner_pin') != null;
      final loggingIn = state.matchedLocation == '/login';

      if (pinSet && !isAuthenticated && !loggingIn) {
        return '/login';
      }
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
        path: '/inventory',
        builder: (context, state) => const ProductListScreen(),
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
