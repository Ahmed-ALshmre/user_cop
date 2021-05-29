import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  String title = "Title";
  String helper = "helper";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
   
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          title = message["notification"]["title"];
          helper = "You have recieved a new notification";
        });
      },
      onResume: (message) async{
        setState(() {
          title = message["data"]["title"];
          helper = "You have open the application from notification";
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(helper),
            Text(
              '$title',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}