import 'package:flutter/material.dart';
import 'package:thrifty/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3B3E4D),
      appBar: AppBar(
        title: Image.asset('assets/thrifty.png', height:60.0, width: 130.0,),
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
        // leading: IconButton(
        //     //padding: new EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 1.0),
        //     icon: Image.asset('assets/thrifty.png'), 
        //     onPressed: null,
        //   ),
        
      ),
    );
  }
}
