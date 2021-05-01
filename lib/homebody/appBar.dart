import 'package:flutter/material.dart';
import 'package:cobonapp_flutter/search/search.dart';
import 'package:rating_dialog/rating_dialog.dart';

// ignore: missing_return
Widget  appBarHome({GlobalKey<ScaffoldState> keySca, BuildContext context}) {
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
        padding: EdgeInsets.only(left: 8.0, right: 8),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
                image: ExactAssetImage(
                  'assets/cont/sua.png',
                ),
                fit: BoxFit.cover),
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
          feedBek(context);
        },
        icon: Icon(
          Icons.favorite_outline_outlined,
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

void feedBek(context){
  showDialog(
      context: context,
      barrierDismissible:
      true, // set to false if you want to force a rating
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
          positiveComment:
          "We are so happy to hear :)",
          // optional
          negativeComment: "We're sad to hear :(",
          // optional
          accentColor: Colors.red,
          // optional
          onSubmitPressed: (int rating) {
            print("onSubmitPressed: rating = $rating");
// TODO: open the app's page on Google Play / Apple App Store
          },
          onAlternativePressed: () {
            print("onAlternativePressed: do something");
// TODO: maybe you want the user to contact you instead of rating a bad review
          },
        );
      });
}