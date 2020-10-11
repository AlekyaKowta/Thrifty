import 'package:thrifty/models/expensemodel.dart';

class User {
  final String uid;
  int maxAmount;
  List<Expense> expenseList;
  User({this.uid});
}
