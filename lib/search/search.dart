import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'appbarsearch.dart';

class SearchProduct extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchProductState createState() => new _SearchProductState();
}
class _SearchProductState extends State<SearchProduct> {
  Future<QuerySnapshot> listQuery;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          bottom: PreferredSize(
            child: serachWid(context),
            preferredSize: Size(56.0, 56.0),
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: listQuery,
          builder: (context, snapShout) {
            return snapShout.hasData
                ? ListView.builder(
                    itemCount: snapShout.data.documents.length,
                    itemBuilder: (context, index) {
                      ItemModel model = ItemModel.fromJson(
                          snapShout.data.documents[index].data);
                      return Container();
                    })
                : Center(
                    child: Text(EcommerceApp.sharedPreferences.getString("la")!=null?"There is no data":'لا توجد بيانات'),
                  );
          },
        ),
      ),
    );
  }
  Widget serachWid(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.99,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextField(
                  onChanged: (value) => startSearch(value),
                  decoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(
                      //     horizontal:0 ,
                      //     vertical:0,
                      // ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText:EcommerceApp.sharedPreferences.getString("la")!=null?"Find the coupon":"البحث عن الكوبون",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              SizedBox(
                child: CountryCodePicker(
                  onChanged: print,
                  hideMainText: true,
                  showFlagMain: true,
                  showFlag: false,
                  initialSelection: 'sa',
                  hideSearch: true,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  alignLeft: true,
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
  Future startSearch(String query) async {
    listQuery = Firestore.instance
        .collection('all')
        .where('title', isGreaterThanOrEqualTo: query)
        .getDocuments();
  }
}
