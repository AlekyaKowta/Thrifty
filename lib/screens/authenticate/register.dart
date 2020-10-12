import 'package:flutter/material.dart';
import 'package:thrifty/services/auth.dart';
import 'package:thrifty/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        : Scaffold(
            backgroundColor: Color(0xFF3B3E4D),
            appBar: AppBar(
              backgroundColor: Colors.black45,
              elevation: 0.0,
              //title: Text('Sign In'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.people,
                    color: Colors.white54,
                  ),
                  label: Text('Sign In',
                      style: TextStyle(color: Colors.white54, fontSize: 20.0)),
                )
              ],
            ),
            body: SingleChildScrollView(
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
                                  borderSide:
                                      new BorderSide(color: Colors.white60)),
                              hintText: "Password",
                              // labelText: "Password",
                              // labelStyle: TextStyle(
                              //     fontSize: 16.0, color: Colors.white54) ,
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
                                child: Text('Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    )),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = "Please type a Valid Email";
                                        loading = false;
                                      });
                                    }
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

//         appBar: AppBar(
//             backgroundColor: Colors.brown[400],
//             elevation: 0.0,
//             title: Text('Register'),
//           actions: <Widget>[
//               FlatButton.icon(
//                 onPressed: (){
//                   widget.toggleView();
//                 },
//                 icon: Icon(Icons.people),
//                 label: Text('Sign In'),
//               )
//             ],
//         ),
//         body: Container(
//           padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: 20.0),
//                 TextFormField(
//                   validator: (val) => val.isEmpty ?  'Enter an Email': null,
//                   onChanged: (val){
//                     setState(() {
//                       email= val;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 TextFormField(
//                   validator: (val) => val.length <6 ? 'Enter a password 6+ chars long ': null,
//                   obscureText: true,
//                   onChanged: (val) {
//                     setState(() {
//                       password = val;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 RaisedButton(
//                   color: Colors.pink[400],
//                   child: Text(
//                       'Register',
//                       style: TextStyle(color: Colors.white)
//                   ),
//                   onPressed: () async{
//                    if (_formKey.currentState.validate()){
//                      setState(() {
//                        loading = true;
//                      });
//                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
//                     if (result == null){
//                         setState(() {
//                           error = "Please type a Valid Email";
//                           loading = false;
//                       });
//                     }
//                    }
//                   },
//
//                 ),
//                 SizedBox(height: 12.0),
//                 Text(
//                   error,
//                   style: TextStyle(color: Colors.red, fontSize: 14.0),
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
// }
