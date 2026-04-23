import 'package:go_router/go_router.dart';
import '../features/auth/auth_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/stock_in/new_delivery_screen.dart';
import '../features/count/count_list_screen.dart';
import '../features/count/new_count_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/reports/audit_log_screen.dart';
import '../features/settings/settings_screen.dart';
import 'widgets/main_layout.dart';

final goRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/physical-count',
          builder: (context, state) => const CountListScreen(),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/stock-in',
      builder: (context, state) => const NewDeliveryScreen(),
    ),
    GoRoute(
      path: '/physical-count/session',
      builder: (context, state) => const NewCountScreen(),
    ),
    GoRoute(
      path: '/audit-log',
      builder: (context, state) => const AuditLogScreen(),
    ),
  ],
);
