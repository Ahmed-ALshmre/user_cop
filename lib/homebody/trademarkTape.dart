import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:provider/provider.dart';
import 'package:cobonapp_flutter/appData/appData.dart';

class TrademarkTape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('imageLogo').snapshots(),
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
                  return Container(
                    height: 90,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        itemCount: model.imageTrad.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Text(
                                        'All',
                                        style: TextStyle(
                                            color: Color(
                                              0xff0A0732,
                                            ),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            model.imageTrad[index]),
                                      )),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                });
        }
      },
    );
  }
}
