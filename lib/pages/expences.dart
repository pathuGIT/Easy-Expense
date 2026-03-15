import 'package:expense_planer/models/expense.dart';
import 'package:expense_planer/server/database.dart';
import 'package:expense_planer/widgets/expense_list.dart';
import 'package:expense_planer/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  //expenseList
  // final List<ExpenseModel> _expenseList = [
  //   ExpenseModel('Shopping', 500.65, DateTime.now(), Category.food),
  //   ExpenseModel('Medicine', 741, DateTime.now(), Category.leasure),
  //   ExpenseModel('Market', 2500, DateTime.now(), Category.leasure),
  //   ExpenseModel('Petrol', 5000, DateTime.now(), Category.leasure),
  // ];
  final _myBox = Hive.box("easyExpensedb");
  Database db = Database();

  Category _selectedCategory = Category.all;
  DateTime _selecteddate = DateTime.now();
  List<ExpenseModel> _filterList = [];
  final TextEditingController _searchController = TextEditingController();
  late ExpenseModel _filteredOne;

  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };

  @override
  void initState() {
    super.initState();
    //calCategoryVal();
    //if this is the first time create the initial data
    if (_myBox.get("ESY_DATA") == null) {
      db.createInitianDb();
      db.updateData();
    } else {
      db.loadData();
    }
    calCategoryVal();
    _filterList = db.expenseList;
  }

  void onAddExpense(ExpenseModel exmodel, bool add) {
    setState(() {
      if (add) {
        db.expenseList.add(exmodel);
      } else {
        print(exmodel.id);

        // find index
        final index = db.expenseList.indexWhere(
          (item) => item.id == exmodel.id,
        );

        if (index != -1) {
          // update the item
          db.expenseList[index] = exmodel;
        }

        print("Updated item: ${db.expenseList[index]}");
      }
    });
    db.updateData();
    calCategoryVal();
  }

  void onDeleteExpese(ExpenseModel exModel) {
    ExpenseModel deletingExpenseModel = exModel;
    //get index remove
    final int removeIndex = db.expenseList.indexOf(exModel);
    setState(() {
      db.expenseList.remove(exModel);
    });
    db.updateData();
    calCategoryVal();

    // snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Delete Successfull!"),
        action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              db.expenseList.insert(removeIndex, deletingExpenseModel);
            });
            db.updateData();
            calCategoryVal();
          },
        ),
      ),
    );
  }

  void _showAddTask() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewExpense(
          onAddExpense: onAddExpense,
          updating: false,
          expenseModel: ExpenseModel(
            "title#44++",
            0,
            _selecteddate,
            Category.all,
          ),
        );
      },
    );
  }

  //PIE Chart
  double foodVal = 0;
  double travelVal = 0;
  double leasureVal = 0;
  double workVel = 0;

  void calCategoryVal() {
    double foodValTotl = 0;
    double travelValTotl = 0;
    double leasureValTotl = 0;
    double workVelTotl = 0;

    for (final expense in db.expenseList) {
      if (expense.category == Category.food) {
        foodValTotl += expense.amount;
      }
      if (expense.category == Category.travel) {
        travelValTotl += expense.amount;
      }
      if (expense.category == Category.leasure) {
        leasureValTotl += expense.amount;
      }
      if (expense.category == Category.work) {
        workVelTotl += expense.amount;
      }
    }

    setState(() {
      dataMap = {
        "Food": foodValTotl,
        "Travel": travelValTotl,
        "Leasure": leasureValTotl,
        "Work": workVelTotl,
      };
    });
  }

  void _filterByCategory(Category value) {
    setState(() {
      if (value == Category.all) {
        _filterList = db.expenseList;
      } else {
        _filterList = db.expenseList.where((item) {
          return item.category == value;
        }).toList();
      }
    });
  }

  void _filterByDate(DateTime value) {
    setState(() {
      _filterList = db.expenseList.where((item) {
        return item.date.year == value.year &&
            item.date.month == value.month &&
            item.date.day == value.day;
      }).toList();
    });
  }

  void _filterByTitle() {
    setState(() {
      _filterList = db.expenseList.where((item) {
        return item.title.toLowerCase().contains(
          _searchController.text.toLowerCase(),
        );
      }).toList();
    });
  }

  Future<void> _openDateOverlay() async {
    try {
      // show date model & store selected date
      final pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year - 1,
          DateTime.now().month,
          DateTime.now().day,
        ),
        lastDate: DateTime(
          DateTime.now().year + 1,
          DateTime.now().month,
          DateTime.now().day,
        ),
      );

      setState(() {
        _selecteddate = pickDate as DateTime;
        _filterByDate(_selecteddate);
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 7, 148),
        elevation: 0,
        title: const Text(
          'Easy Expence',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showAddTask();
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // ===== PIE CHART CARD =====
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      dataMap: dataMap,
                      emptyColor: Colors.grey.shade300,
                      colorList: [
                        Colors.teal,
                        Colors.red,
                        Colors.lightGreenAccent,
                        Colors.deepPurpleAccent,
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Expense Breakdown",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== FILTER BAR =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // SEARCH BAR
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search expense...",
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                      onChanged: (_) => _filterByTitle(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // DATE PICKER
                InkWell(
                  onTap: _openDateOverlay,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.calendar_today, size: 22),
                  ),
                ),

                const SizedBox(width: 10),

                // CATEGORY DROPDOWN
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                          _filterByCategory(value);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ===== EXPENSE LIST =====
          Expanded(
            child: ExpenseList(
              expenseList: _filterList,
              onDeleteExpese: onDeleteExpese,
              onAddExpense: onAddExpense,
            ),
          ),
        ],
      ),
    );
  }
}
