import 'dart:io';
import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'droer/lango.dart';
import 'droer/help.dart';

class LightDrawerPage extends StatelessWidget {
  static final String path = "lib/src/pages/navigation/drawer2.dart";
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange])),
                  child: CircleAvatar(
                    child: FlutterLogo(),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "اسم التطبيق",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "@nameApp",
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(
                    icon: Icons.home,
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "Home page"
                        : "الصفحة الرئيسية"),
                    onp: () {
                      Navigator.pop(context);
                    }),
                _buildDivider(),
                _buildRow(
                    routeImage: "assets/icon/tr.svg",
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "language"
                        : "اللغة"),
                    onp: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LangDriore()));
                    }),
                _buildDivider(),
                _buildRow(
                    routeImage: "assets/icon/what.svg",
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "whats App"
                        : "وتساب"),
                    onp: () {}),
                _buildDivider(),
                _buildRow(
                    routeImage: "assets/icon/face.svg",
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "Facebook"
                        : "فيس بوك"),
                    onp: () {}),
                _buildDivider(),
                _buildRow(
                    routeImage: "assets/icon/twi.svg",
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "twitter"
                        : "تويتر"),
                    onp: () {}),
                _buildDivider(),
                _buildRow(
                    icon: Icons.favorite,
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "Rate the app"
                        : "مراجعات التطبيق"),
                    onp: () {
                      if (Platform.isAndroid) {
                        launchUrl(
                            "https://play.google.com/store/apps/details?id=org.thoughtcrime.securesms");
                      }
                    },
                    showBadge: false),
                _buildDivider(),
                _buildRow(
                    icon: Icons.email,
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "call us"
                        : "اتصل بنا"),
                    onp: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HelpCenter()));
                    }),
                _buildDivider(),
                _buildRow(
                    icon: Icons.info_outline,
                    title: (EcommerceApp.sharedPreferences.getBool("lang")
                        ? "Help"
                        : "المساعدة"),
                    onp: () {}),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(
      {IconData icon,
      String routeImage,
      String title,
      Function onp,
      bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 18.0);
    return InkWell(
      onTap: onp,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          (icon != null)
              ? Icon(
                  icon,
                  size: 25,
                  color: active,
                )
              : SvgPicture.asset(
                  routeImage,
                  height: 30.0,
                  width: 30.0,
                ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "10+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
