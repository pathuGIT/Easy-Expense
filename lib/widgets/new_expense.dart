import 'package:flutter/material.dart';
import 'package:expense_planer/models/expense.dart';
import 'package:intl/intl.dart';

class AddNewExpense extends StatefulWidget {
  final void Function(ExpenseModel expese, bool add) onAddExpense;
  final bool updating;
  final ExpenseModel expenseModel;

  const AddNewExpense({
    super.key,
    required this.onAddExpense,
    required this.updating,
    required this.expenseModel,
  });

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleController = TextEditingController();
  final _amounController = TextEditingController();
  final dateFormatter = DateFormat.yMd();
  Category _selectedCategory = Category.travel;

  DateTime _selecteddate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.expenseModel.title != "title#44++"
        ? widget.expenseModel.category
        : Category.travel;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amounController.dispose();
    super.dispose();
  }

  Future<void> _openDateOverlay() async {
    final pickDate = await showDatePicker(
      context: context,
      initialDate: _selecteddate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickDate == null) return;

    setState(() {
      _selecteddate = pickDate;
    });
  }

  void _handleFormSubmit() {
    final amount = double.tryParse(_amounController.text.trim());

    if (_titleController.text.trim().isEmpty || amount == null || amount <= 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            widget.expenseModel.title == "title#44++"
                ? "Adding Failed!"
                : "Update Failed!",
          ),
          content: Text(
            widget.expenseModel.title == "title#44++"
                ? "Please enter a valid title and amount."
                : "For update, all fields must be required to rewrite.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      );
      return;
    }

    if (widget.expenseModel.title != "title#44++") {
      //updating
      widget.onAddExpense(
        ExpenseModel(
          _titleController.text.trim(),
          amount,
          _selecteddate,
          _selectedCategory,
        ),
        false,
      );
    } else if (widget.expenseModel.title == "title#44++") {
      //adding
      widget.onAddExpense(
        ExpenseModel(
          _titleController.text.trim(),
          amount,
          _selecteddate,
          _selectedCategory,
        ),
        true,
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.expenseModel.title == "title#44++"
                      ? "New Expense"
                      : " Update Expense",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title Field
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: widget.expenseModel.title == "title#44++"
                      ? "Titlem"
                      : widget.expenseModel.title,
                  hintText: "Enter expense title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLength: 50,
              ),
              const SizedBox(height: 16),

              // Amount + Date Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amounController,
                      decoration: InputDecoration(
                        labelText: widget.expenseModel.title == "title#44++"
                            ? "Amount"
                            : widget.expenseModel.amount.toString(),
                        hintText: "0.00",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: _openDateOverlay,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.expenseModel.title == "title#44++"
                                  ? dateFormatter.format(_selecteddate)
                                  : "${widget.expenseModel.date.month}/${widget.expenseModel.date.day}/${widget.expenseModel.date.year}",
                            ),
                            const Icon(Icons.calendar_today, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Category>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: Category.values
                        .map(
                          (e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _handleFormSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      widget.expenseModel.title == "title#44++"
                          ? "Save"
                          : " Update",
                      style: TextStyle(color: Colors.white),
                    ),
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
