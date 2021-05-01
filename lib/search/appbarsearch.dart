import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff03045e),
      iconTheme: IconThemeData(color: Colors.white),
      title: WavyAnimatedTextKit(
        textStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        text: [
          "اسم التطبيق",
          "name app",
        ],
        isRepeatingAnimation: true,
      ),
      centerTitle: true,
      bottom: bottom,
      actions: [
      ],
    );
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
