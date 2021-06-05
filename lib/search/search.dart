import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'appbarsearch.dart';
import 'package:cobonapp_flutter/homebody/body.dart';
import 'package:cobonapp_flutter/appData/appData.dart';

Future<QuerySnapshot> listQuery;

class SearchProduct extends StatefulWidget {
  final String market;
  final String title;

  const SearchProduct({Key key, this.market, this.title}) : super(key: key);

  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String tit;
  void chake() {
    if (EcommerceApp.sharedPreferences.getString("la") == "ar") {
      setState(() {
        tit = "titleAr";
      });
    } else if (EcommerceApp.sharedPreferences.getString("la") == "en") {
      setState(() {
        tit = "titleEn";
      });
    }
  }

bool checchCenter = false;
  bool isCkeck = false;
  @override
  Widget build(BuildContext context) {
    chake();
    return SafeArea(
      child: Scaffold(
          appBar: MyAppBar(
            bottom: PreferredSize(
              child: serachWid(context),
              preferredSize: Size(56.0, 56.0),
            ),
          ),
          body: isCkeck
              ? FutureBuilder<QuerySnapshot>(
                  future: listQuery,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapShout) {
                    if (snapShout.hasError)
                      return new Text('Error: ${snapShout.error}');
                    switch (snapShout.connectionState) {
                      case ConnectionState.waiting:
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(
                            itemCount: snapShout.data.documents.length,
                            itemBuilder: (context, index) {
                              ItemModel model = ItemModel.fromJson(
                                  snapShout.data.documents[index].data);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CopTime1(model: model),
                              );
                            });
                    }
                  },
                )
              : chechCenter()),
    );
  }

  Widget serachWid(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.99,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextField(
                  onChanged: (value) => startSearch(value, 'market'),
                  decoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(
                      //     horizontal:0 ,
                      //     vertical:0,
                      // ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText:
                          EcommerceApp.sharedPreferences.getString("la") != null
                              ? "Find the coupon"
                              : "البحث عن الكوبون",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              SizedBox(
                child: Container(
                  height: 30,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          "${EcommerceApp.sharedPreferences.getString("iamgeCo")}",
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sizedWidth() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.lightGreenAccent,
              Colors.pink,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 40.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration:
                      InputDecoration.collapsed(hintText: "Search here"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// ignore: missing_return
  Future startSearch(String query, String nameSpaes) async {
    // ignore: unrelated_type_equality_checks
    Firestore.instance
        .collection('items')
        .where('market', isEqualTo: query)
        .where("listCatoEn",
            isEqualTo:
                EcommerceApp.sharedPreferences.getStringList("listco").first)
        .getDocuments()
        .then((value) {
      if (value.documents.length != 0) {
        setState(() {
          isCkeck = true;
        });
      listQuery = Firestore.instance
            .collection('items')
            .where('market', isGreaterThanOrEqualTo: query)
            .where('market', isLessThan: query + 'c')
            .where("listCatoEn",
                isEqualTo: EcommerceApp.sharedPreferences
                    .getStringList("listco")
                    .first)
            .getDocuments();
      } else{
        check1Saerch(query);
      }
    });
  }

  Future check1Saerch(String query) async {
    Firestore.instance
        .collection('items')
        .where('titleAr', isEqualTo: query)
        .where("listCatoEn",
            isEqualTo:
                EcommerceApp.sharedPreferences.getStringList("listco").first)
        .getDocuments()
        .then((value) {
      if (value.documents.length != 0) {
        setState(() {
          isCkeck =true;
        });
        listQuery = Firestore.instance
            .collection('items')
            .where('titleAr', isGreaterThanOrEqualTo: query)
            .where('titleAr', isLessThan: query + 'c')
            .where("listCatoEn",
                isEqualTo: EcommerceApp.sharedPreferences
                    .getStringList("listco")
                    .first)
            .getDocuments();
      } else {
        setState(() {
          isCkeck = false;
          checchCenter = true;
        });
      }
    });
  }

  Widget chechCenter(){
if(checchCenter){
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("لا توجد بيانات متطابقه"),
        SizedBox(width: 10,),
        Icon(Icons.emoji_emotions_sharp)
    ],),
  );
}else {
  return Center(child: Text("ابحث عن الكابون"),);
}

  }
}
