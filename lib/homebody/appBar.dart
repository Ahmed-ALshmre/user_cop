import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/search/search.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:cobonapp_flutter/faiver/screen_fav.dart';
import 'package:cobonapp_flutter/home/homescreen.dart';
import 'package:cobonapp_flutter/tools/ecomm.dart';

// ignore: missing_return
Widget appBarHome(
    {Widget getData,GlobalKey<ScaffoldState> keySca, BuildContext context, bool hf,}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: InkWell(
        onTap: () {
          keySca.currentState.openDrawer();
        },
        child: droer()),
    elevation: 0,
    actions: [
      Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8, top: 10, bottom: 10),
        child: InkWell(
          onTap: (){
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return getData;
                });
          },
          child: Container(
            height: 10,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                  image: NetworkImage(
                    "${EcommerceApp.sharedPreferences.getString("iamgeCo")}",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      IconButton(
        icon: Icon(
          Icons.search,
          color: Color(0xff221D71),
          size: 30,
        ),
        onPressed: () {
          Route route =
              MaterialPageRoute(builder: (context) => SearchProduct());
          Navigator.of(context).push(route);
        },
      ),
      IconButton(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => Favorite());
          Route route1 = MaterialPageRoute(builder: (context) => HomeScreen());
          hf ? Navigator.push(context, route) : Navigator.push(context, route1);
          // feedBek(context);
        },
        icon: Icon(
          hf ? Icons.favorite_outline_outlined : Icons.home,
          color: Color(0xff221D71),
          size: 30,
        ),
      ),
    ],
  );
}
Widget droer() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 9),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), color: Color(0xff221D71)),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 6,
          width: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), color: Color(0xff221D71)),
        ),
      ],
    ),
  );
}
void feedBek(context) {
  showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) {
        return RatingDialog(
          icon: const FlutterLogo(
            size: 100,
          ),
          // set your own image/icon widget
          title: "The Rating Dialog",
          description:
              "Tap a star to set your rating. Add more description here if you want.",
          submitButton: "SUBMIT",
          alternativeButton: "Contact us instead?",
          // optional
          positiveComment: "We are so happy to hear :)",
          // optional
          negativeComment: "We're sad to hear :(",
          // optional
          accentColor: Colors.red,
          // optional
          onSubmitPressed: (int rating) {
            print("onSubmitPressed: rating = $rating");

          },
          onAlternativePressed: () {
            print("onAlternativePressed: do something");
          },
        );
      });
}
