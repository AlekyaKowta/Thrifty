import 'package:flutter/material.dart';
import 'package:thrifty/screens/authenticate/authenticate.dart';
import 'package:thrifty/screens/authenticate/sign_in.dart';
import 'package:thrifty/screens/charts.dart';

import 'package:thrifty/services/crud.dart';
import 'package:thrifty/screens/sab.dart';
import 'package:thrifty/services/auth.dart';
import 'package:thrifty/models/expensemodel.dart';
import 'package:thrifty/models/user.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  double total;
  // String warning;
  var getMax;
  DateTime selectedDate = DateTime.now();

  User user = User();

  CrudMethods expenseListMethod;

  initState() {
    super.initState();
    //your code
    //user.maxAmount = 2300.0;
    expenseListMethod = CrudMethods();
    calcTotal();
    //calcRemaining();
  }

  Future<void> calcTotal() async {
    total = await expenseListMethod.getTotal();
    getMax = await expenseListMethod.getMax();

    print(total);
    calcRemaining();
    setState(() {});
  }

  String calcRemaining() {
    String warning = '';
    if (total != null && getMax != null) {
      double max = getMax;

      if (max - total <= 500.0) {
        warning = "Warning! You're reaching your limit";
      } else if (max - total == 0.0) {
        warning = "You've reached your limit, set a new budget";
      } else {
        warning = '';
      }
    }
    // } else {
    //   warning = '';
    // }
    setState(() {});
    return warning;
  }

  Expense expense;

  List<Expense> expenseList = [
    Expense(title: "Pizza", amount: 200.0, time: DateTime.now()),
    Expense(title: "Pasta", amount: 400.0, time: DateTime.now()),
    Expense(title: "Fries", amount: 500.0, time: DateTime.now()),
    Expense(title: "Books", amount: 600.0, time: DateTime.now()),
    Expense(title: "Laundry", amount: 300.0, time: DateTime.now()),
  ];

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

  Future<Expense> showMyDialog(
      BuildContext context, List<Expense> expenseList) async {
    final expenseField = new TextEditingController();
    final descField = new TextEditingController();
    Expense expense = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Color(0xFFEC7F79),
              content: SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Text(
                            'Enter Expenses:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: expenseField,
                            decoration: InputDecoration(
                              hintText: 'Enter your Expenses',
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
                                val.isEmpty ? 'Enter Expenses' : null,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Description:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: descField,
                            decoration: InputDecoration(
                              hintText: 'Description',
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
                                val.isEmpty ? 'Enter Description' : null,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          FlatButton(
                            child: const Icon(
                              Icons.add_circle,
                              color: Color(
                                0xFFE4475B,
                              ),
                              size: 50.0,
                            ),
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  Expense(
                                      title: descField.text,
                                      amount: double.parse(expenseField.text),
                                      time: DateTime.now()));
                              setState(() {
                                expenseListMethod = CrudMethods();
                                expenseListMethod.addExpenses(
                                    descField.text,
                                    double.parse(expenseField.text),
                                    DateTime.now());
                                calcTotal();
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // actions: <Widget>[
              //   FlatButton(
              //     child: const Icon(Icons.add_circle, color: Color(0xFFE4475B,), size: 100.0,),
              //     onPressed: () {
              //       Navigator.of(context).pop(true);
              //       // adding code
              //     },
              //   ),
              // ],
            ));
    return expense;
  }

  Future<Expense> showEditDialog(
      BuildContext context, List<Expense> expenseList, int index) async {
    final expenseField = new TextEditingController();
    final descField = new TextEditingController();
    Expense expense = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Color(0xFFEC7F79),
              content: SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Text(
                            'Enter Expenses:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: expenseField,
                            decoration: InputDecoration(
                              hintText: 'Enter your Expenses',
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
                                val.isEmpty ? 'Enter Expenses' : null,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Description:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: descField,
                            decoration: InputDecoration(
                              hintText: 'Description',
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
                                val.isEmpty ? 'Enter Description' : null,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          FlatButton(
                            child: const Icon(
                              Icons.add_circle,
                              color: Color(
                                0xFFE4475B,
                              ),
                              size: 50.0,
                            ),
                            onPressed: () async {
                              Navigator.pop(
                                  context,
                                  Expense(
                                      title: descField.text,
                                      amount: double.parse(expenseField.text),
                                      time: DateTime.now()));

                              expenseListMethod = CrudMethods();
                              await expenseListMethod.editExpenses(
                                  descField.text,
                                  double.parse(expenseField.text),
                                  DateTime.now(),
                                  index);
                              await calcTotal();
                              setState(() {
                                // expenseListMethod = CrudMethods();
                                // expenseListMethod.editExpenses(
                                //     descField.text,
                                //     double.parse(expenseField.text),
                                //     DateTime.now(),
                                //     index);
                                // calcTotal();
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
    return expense;
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
                  print('cool');
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Authenticate(),
                    ),
                  );
                },
              ),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SetABudget()));
                },
              ),
              // ListTile(
              //   leading:
              //       Icon(Icons.account_balance_wallet, color: Colors.white),
              //   title: Text(
              //     'Expenses',
              //     style: TextStyle(fontSize: 20.0, color: Colors.white),
              //   ),
              //   onTap: () {
              //     // Update the state of the app
              //     // ...
              //     // Then close the drawer
              //     // Navigator.pop(context);
              //     // Navigator.pushNamed(context, Routes.expenses);
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => Expenses()));
              //   },
              // ),
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Charts()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expenses",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () async {
                    Expense returnedEl =
                        await showMyDialog(context, expenseList);
                    setState(() {
                      expenseList.add(returnedEl);
                    });
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Color(0xFFE4475B),
                    size: 43.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
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
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFEC7F79),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  )),
              child: Text("Total: $total".toString(),
                  style: TextStyle(
                    color: Color(0xFFEC7F79),
                    fontSize: 25.0,
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              calcRemaining(),
              style: TextStyle(color: Colors.red[200], fontSize: 16.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FutureBuilder(
                  future: expenseListMethod.fetchMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        await calcTotal();
                        setState(() {});
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildExpenseCard(
                            context,
                            index,
                            snapshot.data[index]['title'],
                            snapshot.data[index]['amount'],
                            snapshot.data[index]['time'],
                          );
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpenseCard(BuildContext context, int index, String title,
      double amount, dynamic time) {
    //final expenseL = expenseList[index];

    if (index % 2 == 0) {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Color(0xFFDB394E),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet, size: 50),
                    title: Text(title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(amount.toStringAsFixed(2),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await showEditDialog(context, expenseList, index);
                            await calcTotal();
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await expenseListMethod.deleteMessage(time);
                            calcTotal();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Color(0xFFEC7F79),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.account_balance, size: 50),
                    title: Text(title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(amount.toStringAsFixed(2),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await showEditDialog(context, expenseList, index);
                            await calcTotal();
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await expenseListMethod.deleteMessage(time);
                            calcTotal();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
