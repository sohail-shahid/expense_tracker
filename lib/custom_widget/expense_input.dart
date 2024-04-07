import 'package:flutter/material.dart';

class ExpenseInputView extends StatefulWidget {
  const ExpenseInputView({super.key});

  @override
  State<ExpenseInputView> createState() {
    return _ExpenseInputState();
  }
}

class _ExpenseInputState extends State<ExpenseInputView> {
  String _title = '';

  void onTitleChange(String text) {
    _title = text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            onChanged: onTitleChange,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          ElevatedButton(
            onPressed: () => print(_title),
            child: const Text('Save Expense'),
          )
        ],
      ),
    );
  }
}
