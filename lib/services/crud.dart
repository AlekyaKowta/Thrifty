import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thrifty/services/auth.dart';
import 'package:thrifty/models/user.dart';
import 'package:thrifty/models/expensemodel.dart';

class CrudMethods {
  // String uid = currentUser;
  String uid;
  CrudMethods() {
    uid = AuthService.currentUseruid;
  }
  // CrudMethods(String uid) {
  //   this.uid = uid;
  // }

  // Future<void> useruid() {
  //   FirebaseUser user = currentUser
  // }

  final databaseReference = Firestore.instance;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createIDRecord() async {
    await databaseReference.collection("Users").document("$uid").updateData({
      'id': '$uid',
    });
  }

  Future<void> addMaxAmount(double maxAmount) async {
    await databaseReference.collection("Users").document("$uid").updateData({
      'maxAmount': '$maxAmount',
    });
  }

  Future<void> addExpenses(String title, double amount, DateTime time) async {
    await databaseReference
        .collection("Users")
        .document("$uid")
        .collection("expenses")
        .document()
        .setData({
          'title': '$title',
          'amount': '$amount',
          'time': '$time',
        });
  }
}
