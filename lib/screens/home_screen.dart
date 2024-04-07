import 'package:expense_tracker/custom_widget/expense_input.dart';
import 'package:expense_tracker/custom_widget/expense_list_view.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ExpenseModel> expenses = [
    ExpenseModel(
        title: 'my first dummy expense',
        amount: 20.0,
        dateCreated: DateTime.now(),
        expenseType: ExpenseType.food),
    ExpenseModel(
        title: 'my second expense',
        amount: 25.033,
        dateCreated: DateTime.now(),
        expenseType: ExpenseType.food),
  ];
  void openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => const ExpenseInputView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('expense chart'),
          Expanded(
            child: ExpenseListView(expenses: expenses),
          ),
        ],
      ),
    );
  }
}
