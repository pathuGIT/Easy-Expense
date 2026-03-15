import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

final uuid = const Uuid().v4(); // create unique id
final dateFormatter = DateFormat.yMd();

enum Category { all, food, travel, leasure, work }

final CategoryIcons = {
  Category.food: Icon(Icons.lunch_dining),
  Category.leasure: Icon(Icons.leak_add),
  Category.travel: Icon(Icons.travel_explore),
  Category.work: Icon(Icons.work),
};

@HiveType(typeId: 1)
class ExpenseModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  ExpenseModel(this.title, this.amount, this.date, this.category) : id = uuid;
  String get getDateFormatter {
    return dateFormatter.format(date);
  }

  Icon get getCategoryIcon {
    return CategoryIcons[category]!;
  }
}
