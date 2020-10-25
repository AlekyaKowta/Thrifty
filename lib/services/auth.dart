import 'package:firebase_auth/firebase_auth.dart';
import 'package:thrifty/models/user.dart';
import 'package:thrifty/services/crud.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String currentUseruid;
  CrudMethods useridmethod;

  //Create user obj based on FireBase User
  User _userFromFirebaseUser(FirebaseUser user) {
    //return user != null ? User(uid: user.uid) : null;

    if (user != null) {
      currentUseruid = user.uid;
      useridmethod = CrudMethods();
      useridmethod.createIDRecord();
      return User(uid: user.uid);
    } else {
      return null;
    }
  }

  // Auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user)=> _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Sign in Anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      //print(user);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign In with Email and Pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print(result.user);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with Email and Pass

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out

  Future signOut() async {
    print(_auth.currentUser().toString());
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
