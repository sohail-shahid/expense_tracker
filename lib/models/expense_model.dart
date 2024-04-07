import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormater = DateFormat.yMd();

enum ExpenseType {
  food,
  travel,
  leisure,
  work,
}

const expenseTypeIcon = {
  ExpenseType.food: Icons.lunch_dining,
  ExpenseType.travel: Icons.flight_takeoff,
  ExpenseType.leisure: Icons.movie,
  ExpenseType.work: Icons.work,
};

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.dateCreated,
    required this.expenseType,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime dateCreated;
  final ExpenseType expenseType;

  String get formatedDate {
    return dateFormater.format(dateCreated);
  }
}
