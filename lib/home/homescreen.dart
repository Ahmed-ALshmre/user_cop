import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cobonapp_flutter/appData/appData.dart';
import 'package:cobonapp_flutter/copontime/hometimer.dart';
import 'package:cobonapp_flutter/model/like.dart';
import 'package:cobonapp_flutter/search/search.dart';
import 'package:cobonapp_flutter/splash/cestmdaelog.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:cobonapp_flutter/tools/sized.dart';
import 'package:cobonapp_flutter/homebody/appBar.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/homebody/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/homebody/trademarkTape.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/deower.dart';
import 'package:cobonapp_flutter/st.dart';
import 'package:cobonapp_flutter/filutter/homeScreenFil.dart';
import 'package:cobonapp_flutter/model/dielogModel.dart';

List<String> imageList = [
  "assets/images/m1.png",
  "assets/images/m2.png",
  "assets/images/m3.png",
];

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<String> list = [
    "مرسول",
    "على اكس ",
    "كريم",
    "وبر",
    "مرسول",
    "على اكس ",
    "كريم",
    "وبر",
  ];
  List<String> eList = [
    "assets/images/m8.svg",
    "assets/images/m9.svg",
    "assets/images/m10.svg",
    "assets/images/m11.svg",
    "assets/images/m8.svg",
    "assets/images/m10.svg",
    "assets/images/m11.svg",
    "assets/images/m9.svg",
  ];
  double paddingValue = 0;
  bool isFav = false;
  Like like = Like();
  int indexNewPro;
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  int index = 0;
  List<String> selectedCountList = [];
  final controller = PageController(viewportFraction: 0.8);
  ScrollController _controllerListVie = new ScrollController(
    initialScrollOffset: 99,
    keepScrollOffset: true,
  );
  displaySplash() {
    Timer(Duration(seconds: 5), () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('diel').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                          controller: _controller,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (contextBuild, index) {
                            DelogM model = DelogM.fromJson(
                                snapshot.data.documents[index].data);
                            print("image ${model.imageDelog}");
                            return CustomDialogBox(
                              imageInText: model.imageDelog,
                              title: EcommerceApp.sharedPreferences
                                          .getString("la") !=
                                      null
                                  ? "Get discounts"
                                  : "احصل على خصومات",
                              descriptions: EcommerceApp.sharedPreferences
                                          .getString("la") !=
                                      null
                                  ? "This text can be controlled from the control panel by changing it at the expense of the need"
                                  : "${model.enTitle}",
                              text: EcommerceApp.sharedPreferences
                                          .getString("la") !=
                                      null
                                  ? "let's go"
                                  : "هيا بنا",
                            );
                          });
                  }
                });
          });
    });
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {});
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('تم التحديث'),
          action: SnackBarAction(
              label: 'مره اخرة',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
  }

  bool toTopBtn = false;
  int count = 50;
  bool ifFloat = false;
  void getCurintIndex() {
    if (_controller.hasClients) {
      setState(() {
        ifFloat = true;
      });
    }
  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _controller = ScrollController();
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    getCurintIndex();
    print(ifFloat);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ifFloat
            ? FloatingActionButton.extended(
                backgroundColor: Colors.cyan,
                label: Container(
                  width: 230,
                  child: Icon(Icons.arrow_upward_rounded),
                ),
                onPressed: () {
                  _controller.animateTo(0.0,
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
              )
            : Container(),
        key: _scaffoldKey,
        appBar: appBarHome(keySca: _scaffoldKey, context: context),
        drawer: LightDrawerPage(),
        backgroundColor: Color(0xffFBFBFB),
        body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //catogrey
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeTime()));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    elevation: 10,
                    child: Container(
                        width: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        height: 120,
                        child: imageSlider1(
                            Provider.of<AppData>(context, listen: false))),
                  ),
                ),
              ),
              // SizedBox(
              //   child: categories(),
              // ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: St(),
              ),
              SizedBox(
                height: 15,
              ),
              TrademarkTape(),
              SizedBox(
                height: 15,
              ),
              Divider(),
              FilDelHome(),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 400,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('items')
                      .where('listCatoEn',
                          whereIn: EcommerceApp.sharedPreferences
                                .getStringList("selectedCountList")).orderBy('bool', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(
                            controller: _controller,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (contextBuild, index) {
                              ItemModel model = ItemModel.fromJson(
                                  snapshot.data.documents[index].data);
                              return CopTime1(model: model);
                            });
                    }
                  },
                ),
              ),
              // DiscountBanner()
            ],
          ),
        ),
      ),
    );
  }

  //text an app first screen
  Widget imageSlider1(var picUp) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('imagefirest').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (contextBuild, index) {
                ItemModel model =
                    ItemModel.fromJson(snapshot.data.documents[index].data);
                print(model.imageList);
                Provider.of<AppData>(context, listen: false)
                    .listConter(model.imageList.length);
                return CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged:
                        (int index, CarouselPageChangedReason reason) {
                      picUp.conterIndex(index);
                    },
                    height: 150,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                  ),
                  items: model.imageList
                      .map(
                        (item) => Container(
                          width: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(
                                item,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            );
        }
      },
    );
  }
// image first
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height ? size.height - 19 : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
