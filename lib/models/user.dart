import 'package:thrifty/models/expenses.dart';

class User {
  final String uid;
  int maxAmount;
  List<Expense> expenseList;
  User({this.uid});
}
