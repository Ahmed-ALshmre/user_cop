import 'package:carousel_slider/carousel_slider.dart';
import 'package:cobonapp_flutter/appData/appData.dart';
import 'package:filter_list/filter_list.dart';
import 'package:cobonapp_flutter/model/like.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:cobonapp_flutter/tools/sized.dart';
import 'package:cobonapp_flutter/homebody/appBar.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/homebody/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/homebody/trademarkTape.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/deower.dart';
import 'package:cobonapp_flutter/st.dart';
import 'package:cobonapp_flutter/main.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double paddingValue = 0;
  bool isFav = false;
  Like like = Like();
  int indexNewPro;
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex;
  _onSelected(int index, String comp) {
    setState(() {
      _selectedIndex = index;
      compin = false;
      compie = comp;
    });
  }

  int index = 0;
  int count = 50;
  bool ifFloat = false;
  void getCurintIndex() {
    if (_controller.hasClients) {
      setState(() {
        ifFloat = true;
      });
    }
  }

  String compie = "";
  bool compin = true;
  List<String> selectedCountList = [];
  List<String> countList = [];
  List<dynamic> whereI = ["rgfdh,dickd"];
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
        appBar: appBarHome(getData: getData(), keySca: _scaffoldKey, context: context, hf: true,),
        drawer: LightDrawerPage(),
        backgroundColor: Color(0xffFBFBFB),
        body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //catogrey
              Align(
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
              compine(),
              SizedBox(
                height: 15,
              ),
              Divider(),
              filter(),
              SizedBox(
                height: 15,
              ), //
              chakeCoimpine(), // DiscountBanner()
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

  Widget flu() {
    if (Provider.of<AppData>(context, listen: false).ctogre != null) {
      print(
          "mamsmasmacmac${Provider.of<AppData>(context, listen: false).ctogre.first}");
      return Container(
        width: 400,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("items")
              .where("listCatoEn",
                  isEqualTo: EcommerceApp.sharedPreferences
                      .getStringList("listco")
                      .first)
              .where("market",
                  isEqualTo:
                      Provider.of<AppData>(context, listen: false).ctogre.first)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('نعتذر يوجد مشكلة تحقاق من الانترنيت');
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
      );
    } else {
      return Container(
        width: 400,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("items")
              .where("listCatoEn",
                  isEqualTo: EcommerceApp.sharedPreferences
                      .getStringList("listco")
                      .first)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('نعتذر يوجد مشكلة تحقاق من الانترنيت');
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
      );
    }
  }

//fi
// ignore: missing_return
  List<String> catoAr = [];
  List<String> catoEn = [];
  Widget filter() {
    return Container(
      height: 40,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('list').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (contextBuild, index) {
                    print("naasmkasanlknsa$catoAr");
                    // ignore: unrelated_type_equality_checks
                    if (catoAr.every((element) =>
                            element !=
                            snapshot.data.documents[index]['artitle']) &&
                        catoEn.every((element) =>
                            element !=
                            snapshot.data.documents[index]['entitle'])) {
                      catoAr.add(snapshot.data.documents[index]['artitle']);
                      catoEn.add(snapshot.data.documents[index]['entitle']);
                      Provider.of<AppData>(context, listen: false)
                          .catog(catoAr, catoEn);
                      print("sdsdddddddddddddssd ");
                    }
                    // Provider.of<AppData>(context,listen: false).catog(catoAr,catoEn);
                    //  print("sdsdddddddddddddssd ");
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          await FilterListDialog.display(context,
                              allTextList: EcommerceApp.sharedPreferences
                                      .getBool("lang")
                                  ? Provider.of<AppData>(context, listen: false)
                                      .arCato
                                  : Provider.of<AppData>(context, listen: false)
                                      .cato,
                              height: 480,
                              borderRadius: 20,
                              headlineText:
                                  EcommerceApp.sharedPreferences.getBool("lang")
                                      ? "Filter"
                                      : "فلتره",
                              searchFieldHintText:
                                  EcommerceApp.sharedPreferences.getBool("lang")
                                      ? "Search"
                                      : "البحث هنا",
                              selectedTextList: selectedCountList,
                              onApplyButtonClick: (list) {
                            if (list != null) {
                              setState(() {
                                selectedCountList = List.from(list);
                                Provider.of<AppData>(context, listen: false)
                                    .ctogreList(selectedCountList);
                              });
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Icon(
                          Icons.filter_alt_outlined,
                          size: 35,
                        ),
                      ),
                    );
                  });
          }
        },
      ),
    );
  }

  // ignore: missing_return
  Widget chakeCoimpine() {
    if (compin) {
      return flu();
    } else {
      print("111111111111111111111111111111111");
      return Container(
        width: 400,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("items")
              .where("listCatoEn",
                  isEqualTo: EcommerceApp.sharedPreferences
                      .getStringList("listco")
                      .first)
              .where("market", isEqualTo: compie)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('نعتذر يوجد مشكلة تحقاق من الانترنيت');
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
      );
    }
  }

  Widget compine() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('diel').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              height: 90,
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Card(
                              elevation: 58,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    shape: BoxShape.circle),
                                child: Text(
                                  EcommerceApp.sharedPreferences.getBool("lang")
                                      ? "All"
                                      : "الكل",
                                  style: TextStyle(
                                      color: Color(
                                        0xff0A0732,
                                      ),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          _onSelected(
                              index, snapshot.data.documents[index]["titleAr"]);
                          print(
                              "22222222222222222222${snapshot.data.documents[index]["titleAr"]}");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: _selectedIndex != null &&
                                    _selectedIndex == index
                                ? 50
                                : 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data.documents[index]['thumbnailUrl']),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
        }
      },
    );
  }
  String dropdownValue = "SU";
  List<String>listco=[];
  Widget getData() {
    return Container(
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('coon').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (contextBuild, index) {
                  ItemModel model =
                  ItemModel.fromJson(snapshot.data.documents[index].data);
                  print("sdsdddddddddddddssd ${model.nameCon}");
                  return ListTile(
                    onTap: () {
                      setState(() {
                        dropdownValue = "${model.nameCon}";
                        listco.add(model.nameCon);
                      });
                      EcommerceApp.sharedPreferences
                          .setString("iamgeCo", model.scienceImage);
                      EcommerceApp.sharedPreferences.setStringList("listco", listco);
                      print(EcommerceApp.sharedPreferences.getStringList('listco'));
                      Route route =
                      MaterialPageRoute(builder: (context) => MyApp());
                      Navigator.push(context, route);
                    },
                    title: Text("${model.nameCon}"),
                    leading: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "${model.scienceImage}",
                              ),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
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
