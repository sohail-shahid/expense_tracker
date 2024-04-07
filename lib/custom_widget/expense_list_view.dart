import 'package:expense_tracker/custom_widget/expense_list_item_view.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key, required this.expenses});
  final List<ExpenseModel> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (cxt, index) =>
          ExpenseListItemView(expense: expenses[index]),
    );
  }
}
