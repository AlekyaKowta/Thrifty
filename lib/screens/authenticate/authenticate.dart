import 'package:flutter/material.dart';
import 'package:thrifty/screens/authenticate/sign_in.dart';
import 'package:thrifty/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF3B3E4D),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          elevation: 0.0,
          //title: Text('Sign In'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                toggleView();
              },
              icon: Icon(
                Icons.people,
                color: Colors.white54,
              ),
              label: showSignIn ?  Text('Register',
                  style: TextStyle(color: Colors.white54, fontSize: 20.0)) : Text('Sign In',
                  style: TextStyle(color: Colors.white54, fontSize: 20.0))
            )
          ],
        ),
        body: showSignIn
            ? SignIn(
                toggleView: toggleView) // passing this tv function to signin

            : Register(toggleView: toggleView));
  }
}
