import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[800],
      child: Center(
        child: SpinKitWave(
          color: Colors.pinkAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
