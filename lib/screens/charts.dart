import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:thrifty/screens/authenticate/authenticate.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:thrifty/services/crud.dart';
import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/screens/sab.dart';
import 'package:thrifty/services/auth.dart';
import 'package:thrifty/shared/loading.dart';

class Charts extends StatefulWidget {
  static const String routeName = '/charts';

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  final AuthService _auth = AuthService();

  DateTime selectedDate = DateTime.now();

  List<double> data = [];

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

    // CrudMethods chartsMethod;

    //   Future<void> chartsData() async {
    //   data = await chartsMethod.chartData();

    //   //orElse: () => null
    //   setState(() {
    //     print(data);
    //   });
    // }

    @override
    initState() {
      super.initState();

      chartsMethod = CrudMethods();
      chartsData();

      //data = await chartsMethod.chartData();
      // List<double> doubleData = data.map((s) => s as double).toList();
      // data = data.map((s) => s as double).ToList();
      // data= data.cast<double>();
      // List<double> fdata = new List<double>.from(data.whereType<double>());
    }

    // List<double> doubleData;
  }

  CrudMethods chartsMethod;

  Future<void> chartsData() async {
    data = await chartsMethod.chartData();
    setState(() {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data != null ? data : Loading();
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
            SizedBox(
              height: 10.0,
            ),
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
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () => _selectDate(context), // Refer step 3
                      child: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      color: Color(0xFFEC7F79),
                    ),
                  ),
                  Flexible(
                      child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 30.0),
                            Text(
                              'Expenses by Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 25.0),
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: new Sparkline(
                                data: data,
                                lineColor: Color(0xFFE4475B),
                                pointColor: Color(0xFFEC7F79),
                                pointsMode: PointsMode.all,
                                pointSize: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
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
