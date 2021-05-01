import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/secScreenLang/uiSplash.dart';

class LangHomeSplash extends StatefulWidget {
  @override
  _LangHomeSplashState createState() => _LangHomeSplashState();
}

class _LangHomeSplashState extends State<LangHomeSplash> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          uiAuth(context, _height, _width, ""),
          SizedBox(
            height: 150,
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'عربي',
                    style: TextStyle(fontSize: 18),
                  ),
                  width: 130,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 60,
                  width: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("English"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
