import 'package:thrifty/models/expensemodel.dart';

class User {
  final String uid;
  double maxAmount;
  List<Expense> expenseList;
  User({this.uid});
}
