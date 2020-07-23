import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class CircularLoad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CircularLoadState();

}

class CircularLoadState extends State<CircularLoad>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black26,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: () {
                  print('tapped');
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircularProgressIndicator( strokeWidth: 1,)))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}