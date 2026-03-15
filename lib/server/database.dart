import 'package:expense_planer/models/expense.dart';
import 'package:hive/hive.dart';

class Database {
  //creat edb refernces
  final _myBox = Hive.box("easyExpensedb");

  //initialize
  List<ExpenseModel> expenseList = [];
  void createInitianDb() {
    expenseList = [
      ExpenseModel(
        'Lunch at Cafe',
        1200.00,
        DateTime.now().subtract(const Duration(days: 1)),
        Category.food,
      ),
      ExpenseModel(
        'Office Taxi',
        850.00,
        DateTime.now().subtract(const Duration(days: 2)),
        Category.travel,
      ),
      ExpenseModel(
        'Movie Night',
        1500.00,
        DateTime.now().subtract(const Duration(days: 3)),
        Category.leasure,
      ),
      ExpenseModel(
        'Stationery',
        300.00,
        DateTime.now().subtract(const Duration(days: 4)),
        Category.work,
      ),
    ];
  }

  //load the data
  void loadData() {
    final dynamic data = _myBox.get("ESY_DATA");
    //validate the data
    if (data != null && data is List<dynamic>) {
      // Check if the data is not null and is a List<dynamic>
      expenseList = data
          .cast<ExpenseModel>()
          .toList(); // Cast it to List<ExpenceModel>
    }
  }

  // update the data
  Future<void> updateData() async {
    await _myBox.put("ESY_DATA", expenseList);
    print("saved data");
  }
}
