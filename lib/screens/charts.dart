import 'package:flutter/material.dart';
import 'package:thrifty/screens/authenticate/sign_in.dart';

import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/screens/sab.dart';
import 'package:thrifty/services/auth.dart';


class Charts extends StatefulWidget {
  static const String routeName = '/charts';

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  final AuthService _auth = AuthService();

    DateTime selectedDate = DateTime.now();


  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });

}

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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignIn()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.home, color: Colors.white),
              //   title: Text(
              //     'Home',
              //     style: TextStyle(fontSize: 20.0, color: Colors.white),
              //   ),
              //   onTap: () {
              //     // Update the state of the app
              //     // ...
              //     // Then close the drawer
              //     //  Navigator.pop(context);
              //     //  Navigator.pushNamed(context, Routes.setabudget);
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => Home()));
                     
              //   },
                
              // ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.white),
                title: Text(
                  'Set A Budget',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  //  Navigator.pop(context);
                  //  Navigator.pushNamed(context, Routes.setabudget);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SetABudget()));
                     
                },
                
              ),
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
              // ListTile(
              //   leading: Icon(Icons.graphic_eq, color: Colors.white),
              //   title: Text(
              //     'Charts',
              //     style: TextStyle(fontSize: 20.0, color: Colors.white),
              //   ),
              //   onTap: () {
              //     // Update the state of the app
              //     // ...
              //     // Then close the drawer
              //     //  Navigator.pop(context);
              //     //  Navigator.pushNamed(context, Routes.charts);
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => Charts()));
                      
              //   },
              // ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Container(
                child: Text(
                  'Charts',
                     style: TextStyle(
                     color: Colors.white,
                     fontSize: 27.0,
                     fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height:10.0,),
                //DatePicker here 
                new Container(
                   child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
          
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: 180.0,
                          height:50.0,
                          child: RaisedButton(
                            onPressed: () => _selectDate(context), // Refer step 3
                            child: Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style:
                                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            color: Color(0xFFEC7F79),
                          ),
                        ),
                      ],
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
