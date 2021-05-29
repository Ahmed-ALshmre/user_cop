import 'dart:async';
import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'appData/appData.dart';
import 'splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;
  runApp(MyApp());
}
// to ensure we have the themeProvider before the app starts lets make a few more changes.
class MyApp extends StatefulWidget with WidgetsBindingObserver {

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Bold"),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale(
              EcommerceApp.sharedPreferences.getString("la") == null
                  ? "en"
                  : EcommerceApp.sharedPreferences.getString("la"),
              ''),
        ],
        debugShowCheckedModeBanner: false,
        title: 'كوبون',
        home: Splash(),
      ),
    );
  }
}