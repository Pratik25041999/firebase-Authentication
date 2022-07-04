import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalSnackBar {
  final String message;
  final Color color;

  const GlobalSnackBar({
    required this.message,
    required this.color,
  });

  static show(
    BuildContext context,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        //behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: color,
        duration: new Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.only(bottom: 50),
        //backgroundColor: Colors.redAccent,
        action: SnackBarAction(
          textColor: Color(0xFFFAF2FB),
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}
