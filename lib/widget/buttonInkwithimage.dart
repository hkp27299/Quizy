import 'package:flutter/material.dart';

Widget buttonInkWithIcon(String text,icon) {
  return Ink(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(30, 186, 142, 1.0),
            Color.fromRGBO(30, 142, 186, 1.0)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30.0)),
    child: Container(
      constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20),
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 30),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
