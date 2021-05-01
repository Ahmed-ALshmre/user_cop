// import 'package:cobonapp_flutter/tools/sized.dart';
// import 'package:flutter/material.dart';
//
// class Categories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<String> categories = [
//        "assets/images/m1.png",
//       "assets/images/m2.png" ,
//        "assets/images/m3.png",
//        "assets/images/m4.jpg",
//        "assets/images/m4.jpg",
//     ];
//     List<String> categoriesText = [
//       "Ali Exp",
//         "Bill",
//        "Game",
//        "Daily Gift",
//      "Daily Gift",
//     ];
//
//     return Padding(
//       padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//       child:  ListView.builder(
//         scrollDirection: Axis.vertical,
//           itemCount: categories.length,
//           itemBuilder: (BuildContext context , index){
//         return CategoryCard(icon:categories[index] , text: categoriesText[index], press: (){});
//       }),
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key key,
//     @required this.icon,
//     @required this.text,
//     @required this.press,
//   }) : super(key: key);
//
//   final String icon, text;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
