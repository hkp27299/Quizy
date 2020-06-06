import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

Widget gameHomeCard(String text, c) {
  return SizedBox(
    height: 100,
    child: Container(
      width: 300,
      child: GradientCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        gradient: c,
        elevation: 10,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
