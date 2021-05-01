import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/tools/sized.dart';
import 'package:flutter/material.dart';

import 'copontame.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {

  @override
  Widget build(BuildContext context) {
    return _drawProducts();}

  Widget _drawProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('items').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ItemModel model =
                  ItemModel.fromJson(snapshot.data.documents[index].data);
                  print(model.thumbnailUrl);
                  return Column(
                    children: [
                      CopTime(model: model,),
                    ],
                  );

                });
        }
      },
    );
  }
}
