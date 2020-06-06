import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

Widget homePageCards(String text, String img, c) {
  return SizedBox(
    height: 100,
    child: Container(
      width: 350,
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
                leading: Image(
                  image: AssetImage(img),
                ),
                title: Text(text,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
