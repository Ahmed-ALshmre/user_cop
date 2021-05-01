import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:cobonapp_flutter/tools/sized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';

import 'homecopontime.dart';

class HomeTime extends StatefulWidget {
  @override
  _HomeTimeState createState() => _HomeTimeState();
}

class _HomeTimeState extends State<HomeTime> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text( EcommerceApp.sharedPreferences.getString("la")!=null?"Temporary discounts":"خصومات موقتة"),
        backgroundColor: Colors.deepPurple,
      ),
      body: PopularProducts(),
    );
  }
}
