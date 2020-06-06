import 'package:flutter/material.dart';
Widget text(String t,double size){
  return Text(
                    t,
                    style: TextStyle(
                        fontSize: size,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.white),
                  );
}