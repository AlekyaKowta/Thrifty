import 'package:flutter/material.dart';
import 'package:thrifty/screens/home/home.dart';
import 'package:thrifty/screens/authenticate/authenticate.dart';
import 'package:thrifty/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // Return Home or Authenticate
    if (user == null){
      return Authenticate();
    } else{
      return Home();
    }
  }
}
