import 'package:flutter/material.dart';


class Not extends StatefulWidget {
  @override
  _NotState createState() => _NotState();
}

class _NotState extends State<Not> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Text("لا يوجد اشعارات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
      ),
    ));
  }
}
