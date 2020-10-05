import 'package:flutter/material.dart';
import 'package:thrifty/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text('Thrifty'),
        backgroundColor: Colors.black45,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(onPressed: () async{
                await _auth.signOut();
          },
              icon: Icon(Icons.people, color: Colors.white54),
              label: Text('Logout', style: TextStyle(color: Colors.white54)),
          )
        ],
      ),
    );
  }
}
