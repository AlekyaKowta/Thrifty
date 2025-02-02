import 'package:flutter/material.dart';
import 'package:thrifty/models/user.dart';
import 'package:thrifty/screens/authenticate/authenticate.dart';
import 'package:thrifty/screens/authenticate/sign_in.dart';
import 'package:thrifty/screens/charts.dart';
import 'package:thrifty/services/crud.dart';

import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/services/auth.dart';

class SetABudget extends StatefulWidget {
  static const String routeName = '/setabudget';

  @override
  _SetABudgetState createState() => _SetABudgetState();
}

class _SetABudgetState extends State<SetABudget> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  final budgetField = new TextEditingController();

  User user = User();

  CrudMethods userSetMaxMethod;

  // @override
  // void initState() {
  //   user.maxAmount;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3B3E4D),
      appBar: AppBar(
        title: Image.asset(
          'assets/thrifty.png',
          height: 60.0,
          width: 130.0,
        ),
        backgroundColor: Colors.black45,
        elevation: 0.0,
      ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor:Color(0xFF3B3E4D), //otherstyles
          canvasColor: Color(0xFFE4475B),
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                //child: Text('Drawer Header'),
                child: Image.asset(
                  'assets/thrifty.png',
                  height: 50.0,
                  width: 80.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
              ),
              ListTile(
                leading: Icon(Icons.people, color: Colors.white),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () async {
                  await _auth.signOut();

                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Authenticate()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.attach_money, color: Colors.white),
              //   title: Text(
              //     'Set A Budget',
              //     style: TextStyle(fontSize: 20.0, color: Colors.white),
              //   ),
              //   onTap: () {
              //     // Update the state of the app
              //     // ...
              //     // Then close the drawer
              //     //  Navigator.pop(context);
              //     //  Navigator.pushNamed(context, Routes.setabudget);
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => SetABudget()));
              //   },
              // ),
              ListTile(
                leading:
                    Icon(Icons.account_balance_wallet, color: Colors.white),
                title: Text(
                  'Expenses',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, Routes.expenses);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()));
                },
              ),
              ListTile(
                leading: Icon(Icons.graphic_eq, color: Colors.white),
                title: Text(
                  'Charts',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //  Navigator.pop(context);
                  //  Navigator.pushNamed(context, Routes.charts);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Charts()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Monthly Budget: ',
                    style: TextStyle(
                        color: Color(0xFFEC7F79),
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: 300.0,
                          child: TextFormField(
                            controller: budgetField,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter your Budget',
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xFFEC7F79),
                                width: 2.0,
                              )),
                            ),
                            style: TextStyle(color: Colors.black),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your Budget' : null,
                            onChanged: (val) {},
                            // setState(() { // set state later to take input
                            //   email= val;
                            // });
                          ),
                        ),
                        SizedBox(height: 40.0),
                        SizedBox(
                            height: 50.0,
                            width: 300.0,
                            child: RaisedButton(
                              color: Color(0xFFE4475B),
                              child: Text('Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                              onPressed: () {
                                setState(() {
                                  user.maxAmount =
                                      double.parse(budgetField.text);
                                  print(user.uid);
                                  userSetMaxMethod = CrudMethods();
                                  userSetMaxMethod.addMaxAmount(user.maxAmount);
                                });
                                print(double.parse(budgetField.text));
                                //addMaxAmount(user.uid, user.maxAmount);
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
