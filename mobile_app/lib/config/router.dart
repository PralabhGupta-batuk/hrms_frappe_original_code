import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/leave/leave_list_screen.dart';
import '../screens/leave/leave_form_screen.dart';
import '../screens/leave/leave_detail_screen.dart';
import '../screens/expense/expense_list_screen.dart';
import '../screens/expense/expense_form_screen.dart';
import '../screens/expense/expense_detail_screen.dart';
import '../screens/attendance/attendance_screen.dart';
import '../screens/attendance/checkin_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../providers/auth_provider.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // Leave routes
      GoRoute(
        path: '/leaves',
        name: 'leaves',
        builder: (context, state) => const LeaveListScreen(),
      ),
      GoRoute(
        path: '/leaves/new',
        name: 'leave-new',
        builder: (context, state) => const LeaveFormScreen(),
      ),
      GoRoute(
        path: '/leaves/:id',
        name: 'leave-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return LeaveDetailScreen(leaveId: id);
        },
      ),
      // Expense routes
      GoRoute(
        path: '/expenses',
        name: 'expenses',
        builder: (context, state) => const ExpenseListScreen(),
      ),
      GoRoute(
        path: '/expenses/new',
        name: 'expense-new',
        builder: (context, state) => const ExpenseFormScreen(),
      ),
      GoRoute(
        path: '/expenses/:id',
        name: 'expense-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ExpenseDetailScreen(expenseId: id);
        },
      ),
      // Attendance routes
      GoRoute(
        path: '/attendance',
        name: 'attendance',
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/checkin',
        name: 'checkin',
        builder: (context, state) => const CheckinScreen(),
      ),
      // Profile route
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      // Add authentication logic here if needed
      return null;
    },
  );
}
