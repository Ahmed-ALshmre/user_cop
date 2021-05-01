import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import 'appData/appData.dart';
class St extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cont =Provider.of<AppData>(context,listen: false).listContry;
  var pro = Provider.of<AppData>(context,);
  print(pro.c);
    return AnimatedSmoothIndicator(
      activeIndex: pro.c,
      count: cont,
      effect: SlideEffect(
          spacing: 8.0,
          radius: 20.0,
          dotWidth: 20.0,
          dotHeight: 16.0,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
          dotColor: Color(0xffFD5118),
          activeDotColor: Color(0xffFD5118)),
    );
  }
}
