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
      'maxAmount': maxAmount,
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
      'amount': amount,
      'time': '$time',
    });
  }

  Future<List<DocumentSnapshot>> fetchMessages() async {
    //time of gettingcurrentuser error

    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .document('$uid')
        .collection('expenses')
        .orderBy('time', descending: true)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    //documents.forEach((data) => print(data));
    return documents;
  }

  Future<double> getTotal() async {
    //time of gettingcurrentuser error
    double total = 0;
    final QuerySnapshot result = await Firestore.instance
        .collection('Users')
        .document('$uid')
        .collection('expenses')
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    documents.forEach((data) {
      total = total + data['amount'];
    });
    return total;
  }

  Future<double> getMax() async {
    //time of gettingcurrentuser error
    
    final maxAmount = await Firestore.instance
        .collection('Users')
        .document('$uid')
        .get().then((value) => value.data['maxAmount']);
    
    return maxAmount;
  }

  
}
