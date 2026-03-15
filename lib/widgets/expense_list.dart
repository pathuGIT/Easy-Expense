import 'package:expense_planer/models/expense.dart';
import 'package:expense_planer/widgets/expense_tile.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expenseList;
  final void Function(ExpenseModel expeseMdl) onDeleteExpese;
  final void Function(ExpenseModel expese, bool add) onAddExpense;

  const ExpenseList({
    super.key,
    required this.expenseList,
    required this.onDeleteExpese,
    required this.onAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(expenseList[index]),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              onDeleteExpese(expenseList[index]);
            },
            child: ExpenseTile(
              expenseTile: expenseList[index],
              onAddExpense: onAddExpense,
            ),
          );
        },
      ),
    );
  }
}
