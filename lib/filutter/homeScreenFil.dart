import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:filter_list/filter_list.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';
class FilDelHome extends StatefulWidget {
  @override
  _FilDelHomeState createState() => _FilDelHomeState();
}
class _FilDelHomeState extends State<FilDelHome> {
  List<String> selectedCountList = [];
  List<String> countList = [];
  @override
  Widget build(BuildContext context) {
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
                    ItemModel model =
                        ItemModel.fromJson(snapshot.data.documents[index].data);
                    print("sdsdddddddddddddssd ${model.entitle}");
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: () async {
                            await FilterListDialog.display(context,
                                allTextList: model.entitle,
                                height: 480,
                                borderRadius: 20,
                                headlineText: "Select Count",
                                searchFieldHintText: "Search Here",
                                selectedTextList: selectedCountList,
                                onApplyButtonClick: (list) {
                              if (list != null) {
                                // ignore: invalid_use_of_protected_member
                                setState(() {
                                  selectedCountList = List.from(list);
                                  print(selectedCountList);
                                  EcommerceApp.sharedPreferences.setStringList(
                                      "selectedCountList", selectedCountList);
                                });
                              }
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(
                            Icons.filter_alt_outlined,
                            size: 35,
                          ),
                      ),
                    );
                  }
                  );
          }
        },
      ),
    );
  }
}
