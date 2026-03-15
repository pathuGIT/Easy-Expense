import 'package:expense_planer/models/expense.dart';
import 'package:expense_planer/pages/expences.dart';
import 'package:expense_planer/server/category_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox("easyExpensedb");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Expences());
  }
}
