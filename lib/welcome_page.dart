import 'package:flutter/material.dart';

class WelcomePagr extends StatefulWidget {
  @override
  _WelcomePagrState createState() => _WelcomePagrState();
}

class _WelcomePagrState extends State<WelcomePagr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}
