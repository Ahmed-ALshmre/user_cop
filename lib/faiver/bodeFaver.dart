import 'dart:async';
import 'dart:math';
import 'package:cobonapp_flutter/home/homescreen.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/tools/pinter.dart';
import 'package:cobonapp_flutter/tools/sized.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cobonapp_flutter/webView/webView.dart';
import 'package:cobonapp_flutter/team.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';

class BodyFav extends StatefulWidget {
  final ItemModel model;
  const BodyFav({
    Key key,
    this.model,
  }) : super(key: key);
  @override
  _BodyFavState createState() => _BodyFavState();
}

class _BodyFavState extends State<BodyFav> with SingleTickerProviderStateMixin {
  bool fav;
  // Refreshing State at Rate of 24/Sec
  List<String> _favId = [];
  bool hint = true;
  bool isFav = false;
  // pint
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return bodyHome(context: context);
  }
// body home
  Widget bodyHome(
      {double size, sizeWid, sizePadding, sizeBox, BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xffFEFEFE),
          ),
          height: 345,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    elevation: 1,
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xffF7F3FF),
                      ),
                      alignment: Alignment.center,
                      height: 80,
                      child: Image.network(
                        widget.model.thumbnailUrl,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        FlutterClipboard.copy('${widget.model.code}')
                            .then((value) {
                          setState(() {
                            hint = false;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        height: 80,
                        width: 100,
                        child: ClipPath(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            color: hint ? Color(0xffFA511A) : Colors.grey,
                            alignment: Alignment.center,
                            child: Text(
                              '${widget.model.code}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          clipper: CustomClipPath(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Container(
             height: 60,
                  child: Text(
                    EcommerceApp.sharedPreferences.getBool("lang") ? widget.model.titleEn:widget.model.titleAr,
                style: TextStyle(
                  height: 1.5,
                  color: Color(0xff05003B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 23, left: 23, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.history,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            EcommerceApp.sharedPreferences.getBool("lang") ?'Last used':"آخر أستخدام",
                            style: TextStyle(
                                height: 1.2, color: Color(0xffB2B1B6),fontSize: 16),
                          ),
                          Text(
                            "${TimeAgo.timeAgoSinceDate(widget.model.dateTime)}",
                            style: TextStyle(
                                height: 1.5, color: Color(0xff76757B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.date_range,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            EcommerceApp.sharedPreferences.getBool("lang") ? 'Expires on ':"تنتهي صلاحيته في",
                            style: TextStyle(
                                height: 1.2, color: Color(0xffB2B1B6)),
                          ),
                          Text(
                            "${TimeAgo.timeAgoSinceDate(widget.model.dateTimeEnd)}",
                            style: TextStyle(
                                height: 1.2, color: Color(0xff76757B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewApp()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 53,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff221D71),
                            ),
                            child: Text(
                              EcommerceApp.sharedPreferences.getBool("lang")?'SHOP NOW':"تسوق الآن",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 53,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF9E4D6),
                            ),
                            child: InkWell(
                              onTap: () async {
                                _favId.remove(widget.model.id);
                                EcommerceApp.sharedPreferences
                                    .setStringList('faver', _favId);
                                setState(() {
                                  isFav = true;
                                });
                              },
                              child: isFav
                                  ? Icon(
                                      Icons.favorite_outline_outlined,
                                      color: Color(0xffCD6645),
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Color(0xffCD6645),
                                    ),
                            ),
                          ),
                          Text(
                            "${widget.model.conter}",
                            style: TextStyle(color: Color(0xff949399)),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 53,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffECEAFE),
                            ),
                            child: InkWell(
                              onTap: () {
                                Share.share("${widget.model.code}");
                              },
                              child: FaIcon(
                                FontAwesomeIcons.telegramPlane,
                                color: Color(0xff807FD9),
                              ),
                            ),
                          ),
                          Text( EcommerceApp.sharedPreferences.getBool("lang") ?'Share':"يشارك",
                              style: TextStyle(
                                color: Color(0xff9E9DA3),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
  void like() async {}
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
