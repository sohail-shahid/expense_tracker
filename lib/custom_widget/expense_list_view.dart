import 'package:expense_tracker/custom_widget/expense_list_item_view.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (cxt, index) => Dismissible(
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index].id),
        background: Container(
          color: Theme.of(context)
              .colorScheme
              .error
              .withOpacity(0.75)
              .withAlpha(50),
          margin: Theme.of(context).cardTheme.margin,
        ),
        child: ExpenseListItemView(expense: expenses[index]),
      ),
    );
  }
}
