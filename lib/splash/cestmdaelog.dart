import 'dart:ui';
import 'package:cobonapp_flutter/splash/toolsdi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/homebody/appBar.dart';
import 'package:cobonapp_flutter/home/homescreen.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text, imageInText;
  final Image img;
  const CustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.imageInText})
      : super(key: key);
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}
class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xff03045e),
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              widget.imageInText != null
                  ? Container(
                      height: 400,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.imageInText,
                            ),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Text(
                      widget.descriptions,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
              SizedBox(
                height: 22,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        feedBek(context);
                      },
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton(
                    onPressed: () {},
                    child: ClipPath(
                      child: Container(
                        width: 80,
                        height: 70,
                        color: Colors.grey,
                        alignment: Alignment.center,
                        child: Text(
                          'DE12F',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      clipper: CustomClipPath(),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset("assets/images/m3.png"),
            ),
          ),
        ),
      ],
    );
  }
}