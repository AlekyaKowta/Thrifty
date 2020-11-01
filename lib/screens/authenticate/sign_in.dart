import 'package:flutter/material.dart';
import 'package:thrifty/models/user.dart';
import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/services/auth.dart';
import 'package:thrifty/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text Field State

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                  Container(
                    height: 100.0,
                    width: 220.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/thrifty.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          style: TextStyle(color: Colors.white54),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white60)),
                            hintText: "Email ID",
                            hintStyle: TextStyle(
                                fontSize: 16.0, color: Colors.white54),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          style: TextStyle(color: Colors.white54),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long '
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white60),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontSize: 16.0, color: Colors.white54),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        SizedBox(
                            height: 50.0,
                            width: 320.0,
                            child: RaisedButton(
                              color: Color(0xFFE4475B),
                              child: Text('Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                              onPressed: () async {
                                try {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    /// check is there is a user and navigate to the home page
                                    var result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result is User) {
                                      /// this will remove all pages and push the [Home()] on top
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                        (route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        error = "Please try again";
                                      });
                                    }
                                  }
                                } catch (e) {
                                  setState(() {
                                    error = e.message;
                                  });
                                } finally {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                            )),
                        SizedBox(height: 10.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
