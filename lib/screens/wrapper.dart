import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thrifty/shared/loading.dart';
import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/screens/authenticate/authenticate.dart';
import 'package:thrifty/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //// final user = Provider.of<User>(context);
    //// print(user);

    //// Return Home or Authenticate
    // if (user == null) {
    //   print('yes');
    //   return Authenticate();
    // } else {
    //   print('no');
    //   return Home();
    // }

    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          // final user = Provider.of<User>(context);
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Loading();
          // } else

          if (snapshot.data is FirebaseUser) {
            return Home();
          } else {
            return Authenticate();
          }

          // return Authenticate();
        });
  }
}
