import 'package:flutter/material.dart';

import 'package:thrifty/screens/wrapper.dart';

import 'package:provider/provider.dart';
import 'package:thrifty/services/auth.dart';
import 'package:thrifty/models/user.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );

    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.onAuthStateChanged,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return Home();
    //     }
    //     return Authenticate();
    //   },
    // );
  }
}
