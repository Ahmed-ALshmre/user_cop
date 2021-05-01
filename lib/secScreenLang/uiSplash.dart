import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/secScreenLang/cestm.dart';
Widget uiAuth(context, double _height,_width ,String text) {
  return Stack(
    children: <Widget>[
      Opacity(
        opacity: 0.75,
        child: ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: _height / 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[200], Colors.pinkAccent],
              ),
            ),
          ),
        ),
      ),
      Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper: CustomShapeClipper2(),
          child: Container(
            height: _height / 3.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[200], Colors.pinkAccent],
              ),
            ),
          ),
        ),
      ),
      Opacity(
        opacity: 0.25,
        child: ClipPath(
          clipper: CustomShapeClipper3(),
          child: Container(
            height: _height / 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[200], Colors.pinkAccent],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding:EdgeInsets.only(top: 150),
        child: Container(
          alignment: Alignment.center,
          child: Text(text,),
        ),
      ),
    ],
  );
}