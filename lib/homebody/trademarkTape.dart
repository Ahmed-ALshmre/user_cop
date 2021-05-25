// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cobonapp_flutter/tools/ecomm.dart';
// // ignore: must_be_immutable
// class TrademarkTape extends StatefulWidget {
//   final Function onTap;
//   const TrademarkTape({Key key, this.onTap}) : super(key: key);
//   @override
//   _TrademarkTapeState createState() => _TrademarkTapeState();
// }
// class _TrademarkTapeState extends State<TrademarkTape> {
//   List<String> imageList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('diel').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return new Center(
//               child: CircularProgressIndicator(),
//             );
//           default:
//             return Container(
//               height: 90,
//               alignment: Alignment.center,
//               child: ListView.builder(
//                   itemCount: snapshot.data.documents.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     if (index == 0) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: Card(
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(40)),
//                             child: Container(
//                               alignment: Alignment.center,
//                               height: 80,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 5,
//                                       blurRadius: 7,
//                                       offset: Offset(
//                                           0, 3), // changes position of shadow
//                                     ),
//                                   ],
//                                   shape: BoxShape.circle),
//                               child: Text(
//                                 EcommerceApp.sharedPreferences.getBool("lang")
//                                     ? "All"
//                                     : "الكل",
//                                 style: TextStyle(
//                                     color: Color(
//                                       0xff0A0732,
//                                     ),
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                     return Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: InkWell(
//                         onTap: () {
//                           _onSelected(index);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 5,
//                                 blurRadius: 7,
//                                 offset:
//                                     Offset(0, 3), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Card(
//                             color: Colors.black,
//                             elevation: _selectedIndex != null &&
//                                     _selectedIndex == index
//                                 ? 0
//                                 : 50,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(40)),
//                             child: Container(
//                               alignment: Alignment.center,
//                               height: 80,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   image: NetworkImage(snapshot
//                                       .data.documents[index]['thumbnailUrl']),
//                                 ),
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             );
//         }
//       },
//     );
//   }
// }