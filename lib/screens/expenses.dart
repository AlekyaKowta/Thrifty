import 'package:flutter/material.dart';
import 'package:thrifty/screens/charts.dart';
import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/screens/sab.dart';
import 'package:thrifty/services/auth.dart';

class Expenses extends StatefulWidget {
  static const String routeName = '/expenses';

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
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
                  //Navigator.pop(context);
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
                      MaterialPageRoute(builder: (context) => Expenses()));
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
        padding: const EdgeInsets.all(20.0),
        child: Container(
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
                      onPressed: () {
                        showMyDialog(context);
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Color(0xFFE4475B),
                        size: 53.0,
                      )
                      ),
                ],
              ),
              SizedBox(height:10.0,),
              //DatePicker here 
              new Container(
                 child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Text(
                      //   "${selectedDate.toLocal()}".split(' ')[0],
                      //   style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold, color: Colors.white,),
                      // ),
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
              SizedBox(height:10.0,),
              new Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(10.0),
                    
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFEC7F79), width:2.0,),
                      borderRadius: BorderRadius.all(Radius.circular(5.0),)
                    ),
                    child: Text(
                      " Total: Rs.200 ",
                      style: TextStyle(color: Color(0xFFEC7F79), fontSize: 25.0,)
                      ),
                  ),
                SingleChildScrollView(
                    child: new Container(
                    child: Column(
                      children: [
                        SizedBox(height:10.0,),
                        Card(
                          color: Color(0xFFDB394E),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              
                              children: <Widget>[
                                 ListTile(
                                  leading: Icon(Icons.album, size: 50),
                                  title: Text('Pizza',style:TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('500',style:TextStyle(fontWeight: FontWeight.bold)),
                                  trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                        ],
                                      ),
                                  
                                ),
                              ],
                            ),
                        ),
                        SizedBox(height:10.0,),
                        Card(
                          color: Color(0xFFEC7F79),
                          child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              
                              children: <Widget>[
                                 ListTile(
                                  leading: Icon(Icons.album, size: 50),
                                  title: Text('Pizza',style:TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('500',style:TextStyle(fontWeight: FontWeight.bold)),
                                  trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                        ],
                                      ),
                                  
                                ),
                              ],
                            ),
                        ),
                        SizedBox(height:10.0,),
                        Card(
                          color: Color(0xFFDB394E),
                          child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              
                              children: <Widget>[
                                 ListTile(
                                  leading: Icon(Icons.album, size: 50),
                                  title: Text('Pizza',style:TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('500',style:TextStyle(fontWeight: FontWeight.bold)),
                                  trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                        ],
                                      ),
                                  
                                ),
                              ],
                            ),
                        ),
                        SizedBox(height:10.0,),
                        Card(
                          color: Color(0xFFEC7F79),
                          child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              
                              children: <Widget>[
                                 ListTile(
                                  leading: Icon(Icons.album, size: 50),
                                  title: Text('Pizza',style:TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('500',style:TextStyle(fontWeight: FontWeight.bold)),
                                  trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
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
                  ),
                )
            ],
          ),
          
          ),
      ),
    );
    
  }
}

 void showMyDialog(BuildContext context) {
                    showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
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
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0,),
                                        ),
                                      SizedBox(height:10.0,),
                                      TextFormField(
                                        decoration: InputDecoration(
                                              hintText: 'Enter your Expenses',
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width:2.0,)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xFFEC7F79), width:2.0,)
                                                ),
                                            ),
                                              style: TextStyle(color: Colors.black),
                                              validator: (val) => val.isEmpty ?  'Enter Description': null,
                                              onChanged: null,
                                      ),
                                      SizedBox(height: 20.0,),
                                      Text(
                                        'Description:',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0,),
                                        ),
                                      SizedBox(height:10.0,),
                                      TextFormField(
                                        decoration: InputDecoration(
                                              hintText: 'Description',
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width:2.0,)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xFFEC7F79), width:2.0,)
                                                ),
                                            ),
                                              style: TextStyle(color: Colors.black),
                                              validator: (val) => val.isEmpty ?  'Enter your Budget': null,
                                              onChanged: null,
                                      ),
                                      SizedBox(height:40.0,),
                                      FlatButton(
                                      child: const Icon(Icons.add_circle, color: Color(0xFFE4475B,), size: 50.0,),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                              // adding code
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
                        );
                      },
                    );
                  }
                