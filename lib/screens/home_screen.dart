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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('app bar'),
          const Text('expense chart'),
          const Text('expense list'),
          Expanded(
            child: ExpenseListView(expenses: expenses),
          ),
        ],
      ),
    );
  }
}
