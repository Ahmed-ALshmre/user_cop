
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'ecomm.dart';

class AnimatedWidgetWidget extends StatefulWidget {
final String text;
final String copy;
final Function onpres;
  const AnimatedWidgetWidget({Key key, this.text, this.copy, this.onpres}) : super(key: key);
 @override
  _AnimatedWidgetWidgetState createState() => _AnimatedWidgetWidgetState();
}
class _AnimatedWidgetWidgetState extends State<AnimatedWidgetWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  // double isValue
  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      lowerBound: 0.01,
      upperBound: 10,
    )..repeat(reverse: true);
    super.initState();
  }
  bool state=false;
   String copy="انسخ الكود";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: (){
              _controller.stop();
              setState(() {
                copy="efg1";
                state = true;
              });
              widget.onpres();
            },
            child: ButtonTransition( copy,
                _controller,
                this,
                state,
                width: _controller  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
// ignore: must_be_immutable
class ButtonTransition extends AnimatedWidget {
  // ignore: unused_field
  final AnimationController _controller;
  final String name;
  // ignore: unused_field
  final State _state;
  final bool stat;
   ButtonTransition(this.name, this._controller, this._state, this.stat, {width }) : super(listenable: width);
  Animation<double> get _width => listenable;
  String title = ""
      "أنسخ الكود";
  @override
  Widget build(BuildContext context) {
    return stat ? pr(
       Container(
        alignment: Alignment.center,
        height: 50,
        width: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( EcommerceApp.sharedPreferences.getString("la")!=null? "Copied":"تم النسخ"),
            SizedBox(width: 10,),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          ],
        ),
      ),
    ):Container(
      alignment: Alignment.center,
      height: 50,
      width: 140,
        decoration: BoxDecoration(
        border: Border.all(width: stat ? 1: _width.value )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            Text(EcommerceApp.sharedPreferences.getString("la")!=null?"Copy code":name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          ],
        ),
    );
  }
}
pr(Widget child ){
  return  DottedBorder(
    color: Colors.black,
    strokeWidth: 3,
    radius: Radius.circular(5),
    dashPattern: [20, 5],
    customPath: (size) {
      return Path()
        ..moveTo(10, 0)
        ..lineTo(size.width - 5, 0)
        ..arcToPoint(Offset(size.width, 5), radius: Radius.circular(5))
        ..lineTo(size.width, size.height -5)
        ..arcToPoint(Offset(size.width - 5, size.height), radius: Radius.circular(5))
        ..lineTo(5, size.height)
        ..arcToPoint(Offset(0, size.height -5), radius: Radius.circular(5))
        ..lineTo(0, 5)
        ..arcToPoint(Offset(5, 0), radius: Radius.circular(5));
    },
    child: child,
  );
}