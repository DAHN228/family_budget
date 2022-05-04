import 'package:family_budget/pages/chart.dart';
import 'package:family_budget/pages/reports.dart';
import 'package:family_budget/pages/income-report.dart';
import 'package:family_budget/pages/expenses-report.dart';
import 'package:flutter/material.dart';
import 'package:family_budget/pages/budget.dart';
import 'package:family_budget/pages/main-screen.dart';
import 'package:family_budget/pages/form.dart';
import 'package:family_budget/pages/login.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => const MainScreen(),
    '/budget': (context) => const Budget(),
    '/form': (context) => const EntryForm(),
    '/reports': (context) => const Reports(),
    '/login': (context) => const Login(),
    '/chart': (context) => Chart(),
    '/income-report': (context) => const IncomeReport(),
    '/expenses-report': (context) => const ExpensesReport(),
  },
));

