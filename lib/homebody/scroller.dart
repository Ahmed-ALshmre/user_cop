import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/homebody/body.dart';
class Data extends StatefulWidget {
final ScrollController controllerListVie;
final BuildContext contextBuild;
  const Data({Key key, this.controllerListVie, this.contextBuild}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return _drawProducts();
  }

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
              controller: widget.controllerListVie,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (contextBuild, index) {
                  ItemModel model =
                  ItemModel.fromJson(snapshot.data.documents[index].data);
                  print(model.thumbnailUrl);
                  return CopTime1(model: model);
                });
        }
      },
    );
  }
}
