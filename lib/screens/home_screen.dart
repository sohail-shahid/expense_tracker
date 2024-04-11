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
      isScrollControlled: true,
      context: context,
      builder: (sheetContext) => ExpenseInputView(
        onAddExpense: onAddExpense,
      ),
    );
  }

  void onAddExpense(ExpenseModel model) {
    setState(() {
      expenses.add(model);
    });
  }

  void onRemoveExpense(ExpenseModel model) {
    int indexOfExpense = expenses.indexOf(model);
    setState(() {
      expenses.remove(model);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
          onPressed: () {
            setState(() {
              expenses.insert(indexOfExpense, model);
            });
          },
          label: 'Undo',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget dataContent = const Center(
      child: Text('No Expense Present'),
    );

    if (expenses.isNotEmpty) {
      dataContent = ExpenseListView(
        expenses: expenses,
        onRemoveExpense: onRemoveExpense,
      );
    }
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
            child: dataContent,
          ),
        ],
      ),
    );
  }
}
