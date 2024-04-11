import 'package:expense_tracker/models/expense_model.dart';

class GroupExpenseModel {
  GroupExpenseModel(this.expenses, this.expenseType);

  GroupExpenseModel.byExpenseType(
      List<ExpenseModel> allExpenses, this.expenseType)
      : expenses = allExpenses
            .where((expense) => expense.expenseType == expenseType)
            .toList();

  final ExpenseType expenseType;
  final List<ExpenseModel> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
