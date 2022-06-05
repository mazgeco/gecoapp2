import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final boxDecoration = const BoxDecoration(
  gradient: LinearGradient(
        colors: [
          Color(0xff036077),
          Color(0xff0546b2),
        ]
      )
  );

  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Purple Gradient
        Container(decoration: boxDecoration),
        //Pink box
        //Positioned(top: -100, left: -30, child: _PinkBox()),
      ],
    );
  }
}
