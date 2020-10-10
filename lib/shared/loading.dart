import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF3B3E4D),
      child: Center(
        child: SpinKitWave(
          color: Color(0xFFE4475B),
          size: 50.0,
        ),
      ),
    );
  }
}
//comment
