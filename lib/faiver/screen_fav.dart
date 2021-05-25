import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'bodeFaver.dart';
import 'package:cobonapp_flutter/homebody/appBar.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(keySca: _scaffoldKey, context: context, hf: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getDataFire(),
      ),
    );
  }

  Widget getDataFire() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('items')
          .where('id',
              whereIn: EcommerceApp.sharedPreferences.getStringList('faver'))
          .orderBy('bool', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
                child: Text(
              "☹ لا توجد مفضلات ",
              style: TextStyle(fontSize: 24),
            ));
          default:
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (contextBuild, index) {
                  ItemModel model =
                      ItemModel.fromJson(snapshot.data.documents[index].data);
                  return BodyFav(model: model);
                });
        }
      },
    );
  }
}
