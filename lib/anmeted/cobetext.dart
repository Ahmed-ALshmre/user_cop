import 'dart:math';
import 'package:flutter/material.dart';

class SlideCardWidget extends StatefulWidget {
  @override
  _SlideCardWidgetState createState() => _SlideCardWidgetState();
}

class _SlideCardWidgetState extends State<SlideCardWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AnimCard(
          Colors.orange,
          '01',
          'FIRST',
          '[Color] and [ColorSwatch] constants which represent Material design',
        ),

      ],
    );
  }
}

class AnimCard extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;

  AnimCard(this.color, this.num, this.numEng, this.content);

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[

          Align(
            alignment: Alignment.centerRight,
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final onTap;

  CardItem(this.color, this.num, this.numEng, this.content, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: onTap,
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    var arcPath = Path.combine(
      PathOperation.difference,
      path,
      Path()
        ..addArc(
          Rect.fromCircle(
            center: Offset(0, size.height / 2),
            radius: size.height / 9,
          ),
          0,
          2 * pi,
        ),
    );
    return arcPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
