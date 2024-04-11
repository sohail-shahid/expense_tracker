import 'dart:io';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseInputView extends StatefulWidget {
  const ExpenseInputView({super.key, required this.onAddExpense});
  final void Function(ExpenseModel) onAddExpense;

  @override
  State<ExpenseInputView> createState() {
    return _ExpenseInputState();
  }
}

class _ExpenseInputState extends State<ExpenseInputView> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseType _selectedExpenseType = ExpenseType.leisure;

  void presentDatePicker() {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 1, today.month, today.day);
    showDatePicker(
            context: context,
            initialDate: today,
            firstDate: firstDate,
            lastDate: today)
        .then(
      (value) => setState(() {
        _selectedDate = value;
      }),
    );
  }

  void onSaveButtonPressed() {
    final amount = double.tryParse(_amountController.text);
    final isInValidAmount = (amount == null || amount <= 0.0);

    if (_titleController.text.trim().isEmpty ||
        isInValidAmount ||
        _selectedDate == null) {
      showDailog();
    } else {
      widget.onAddExpense(ExpenseModel(
          title: _titleController.text,
          amount: amount,
          dateCreated: _selectedDate!,
          expenseType: _selectedExpenseType));
      Navigator.pop(context);
    }
  }

  void showDailog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure a valid ammount or title is added'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure a valid ammount or title is added'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 100, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : dateFormater.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownButton(
                      value: _selectedExpenseType,
                      items: ExpenseType.values
                          .map(
                            (expenseType) => DropdownMenuItem(
                              value: expenseType,
                              child: Text(
                                expenseType.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedExpenseType = value ?? ExpenseType.food;
                        });
                      }),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: onSaveButtonPressed,
                    child: const Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
