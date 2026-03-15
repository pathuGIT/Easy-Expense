import 'package:expense_planer/models/expense.dart';
import 'package:expense_planer/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expenseTile;
  final void Function(ExpenseModel expese, bool add) onAddExpense;
  const ExpenseTile({
    super.key,
    required this.expenseTile,
    required this.onAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddNewExpense(
              onAddExpense: onAddExpense,
              updating: true,
              expenseModel: expenseTile,
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenseTile.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Rs. ${expenseTile.amount.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 12),
                  ), //toStringAsFixed for two decimal
                  const Spacer(),
                  Row(
                    children: [
                      Icon(expenseTile.getCategoryIcon.icon),
                      const SizedBox(width: 8),
                      Text(expenseTile.getDateFormatter),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
