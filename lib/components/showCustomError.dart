import 'dart:ui';

import 'package:flutter/material.dart';

showSnackBar(
    String message, final scaffoldKey, BuildContext context, Color color) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.0),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 4),
    ),
  );
}