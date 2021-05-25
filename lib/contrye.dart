import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/secScreenLang/uiSplash.dart';
import 'model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lan/deldgt.dart';
import 'tools/ecomm.dart';
class Conutry extends StatefulWidget {
  @override
  _ConutryState createState() => _ConutryState();
}
class _ConutryState extends State<Conutry> {
  String dropdownValue = "SU";
  List<String> listco = [];
  String imageDropdownValue =
      "https://firebasestorage.googleapis.com/v0/b/copone-58cf5.appspot.com/o/su.png?alt=media&token=54f94e9f-c704-4cc9-a298-54ae2f47de38";
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          uiAuth(context, _height, _width, ""),
          SizedBox(
            height: 100,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerRight,
            child: Text(
              " * الرجاء تحديد البلد",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(),
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return _getData();
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '$dropdownValue',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 35,
                            width: 50,
                            child: Image.network(
                              "$imageDropdownValue",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.arrow_drop_down_sharp),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getData() {
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
                      EcommerceApp.sharedPreferences
                          .setStringList("listco", listco);
                      print(EcommerceApp.sharedPreferences
                          .getStringList('listco'));
                      Route route =
                          MaterialPageRoute(builder: (context) => LangCode());
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
