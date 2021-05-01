import 'dart:async';
import 'dart:math';
import 'package:cobonapp_flutter/home/homescreen.dart';
import 'package:cobonapp_flutter/model/model.dart';
import 'package:cobonapp_flutter/tools/pinter.dart';
import 'package:cobonapp_flutter/tools/sized.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cobonapp_flutter/webView/webView.dart';
import 'package:cobonapp_flutter/team.dart';
class CopTime1 extends StatefulWidget {
  final ItemModel model;
  const CopTime1({
    Key key,
    this.model,
  }) : super(key: key);
  @override
  _CopTime1State createState() => _CopTime1State();
}

class _CopTime1State extends State<CopTime1>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  final List<Color> colors = [
    Color(0xffffc100),
    Color(0xffff9a00),
    Color(0xffff7400),
    Color(0xffff4d00),
    Color(0xffff0000)
  ];
  final GlobalKey _boxKey = GlobalKey();
  final Random random = Random();
  final double gravity = 9.81,
      dragCof = 1.47,
      airDensity = 1.1644,
      fps = 1 / 42;
  Timer timer;
  Rect boxSize = Rect.zero;
  List<Particle> particles = [];
  dynamic counterText = {"count": 0, "color": Color(0xffffc100)};

  @override
  void dispose() {
    // Cancel and Dispose off timer and Animation Controller
    timer.cancel();
    _animationController.removeListener(_animationListener);
    _animationController.dispose();
    super.dispose();
  }
  bool fav;
  @override
  void initState() {
    // AnimationController for initial Burst Animation of Text
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween(begin: 1.0, end: 2.0).animate(_animationController);

    // Getting the Initial size of Container as soon as the First Frame Renders
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Size size = _boxKey.currentContext.size;
      boxSize = Rect.fromLTRB(0, 0, size.width, size.height);
    });

    // Refreshing State at Rate of 24/Sec
    timer = Timer.periodic(
        Duration(milliseconds: (fps * 1000).floor()), frameBuilder);
    super.initState();
  }

  _animationListener() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  frameBuilder(dynamic timestamp) {
    // Looping though particles to calculate their new position
    particles.forEach((pt) {
      //Calculating Drag Force (DRAG FORCE HAS TO BE NEGATIVE - MISSED THIS IN THE TUTORIAL)
      double dragForceX =
          -0.5 * airDensity * pow(pt.velocity.x, 2) * dragCof * pt.area;
      double dragForceY =
          -0.5 * airDensity * pow(pt.velocity.y, 2) * dragCof * pt.area;

      dragForceX = dragForceX.isInfinite ? 0.0 : dragForceX;
      dragForceY = dragForceY.isInfinite ? 0.0 : dragForceY;

      // Calculating Acceleration
      double accX = dragForceX / pt.mass;
      double accY = gravity + dragForceY / pt.mass;

      // Calculating Velocity Change
      pt.velocity.x += accX * fps;
      pt.velocity.y += accY * fps;

      // Calculating Position Change
      pt.position.x += pt.velocity.x * fps * 100;
      pt.position.y += pt.velocity.y * fps * 100;

      // Calculating Position and Velocity Changes after Wall Collision
      boxCollision(pt);
    });
    if (particles.isNotEmpty) {
      setState(() {});
    }
  }

  burstParticles() {
    // Removing Some Old particles each time FAB is Clicked (PERFORMANCE)
    if (particles.length > 1) {
      particles.removeRange(0, 75);
    }
    _animationController.forward();
    _animationController.addListener(_animationListener);

    double colorRandom = random.nextDouble();

    Color color = colors[(colorRandom * colors.length).floor()];
    String previousCount = "${counterText['count']}";
    Color prevColor = counterText['color'];
    counterText['count'] = counterText['count'] + 1;
    counterText['color'] = color;
    int count = random.nextInt(25).clamp(5, 25);

    for (int x = 0; x < count; x++) {
      double randomX = random.nextDouble() * 4.0;
      if (x % 1 == 0) {
        randomX = -randomX;
      }
      double randomY = random.nextDouble() * -7.0;
      Particle p = Particle();
      p.radius = (random.nextDouble() * 100.0).clamp(2.0, 10.0);
      p.color = prevColor;
      p.position = PVector(boxSize.center.dx, boxSize.center.dy);
      p.velocity = PVector(randomX, randomY);
      particles.add(p);
    }

    List<String> numbers = previousCount.split("");
    for (int x = 0; x < numbers.length; x++) {
      double randomX = random.nextDouble();
      if (x % 2 == 0) {
        randomX = -randomX;
      }
      double randomY = random.nextDouble() * -7.0;
      Particle p = Particle();
      p.type = ParticleType.TEXT;
      p.text = numbers[x];
      p.radius = 25;
      p.color = color;
      p.position = PVector(boxSize.center.dx, boxSize.center.dy);
      p.velocity = PVector(randomX * 4.0, randomY);
      particles.add(p);
    }
  }

  boxCollision(Particle pt) {
    // Collision with Right of the Box Wall
    if (pt.position.x > boxSize.width - pt.radius) {
      pt.velocity.x *= pt.jumpFactor;
      pt.position.x = boxSize.width - pt.radius;
    }
    // Collision with Bottom of the Box Wall
    if (pt.position.y > boxSize.height - pt.radius) {
      pt.velocity.y *= pt.jumpFactor;
      pt.position.y = boxSize.height - pt.radius;
    }
    // Collision with Left of the Box Wall
    if (pt.position.x < pt.radius) {
      pt.velocity.x *= pt.jumpFactor;
      pt.position.x = pt.radius;
    }
  }
bool hint = true;
  bool isFav = true;
  // pint
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return bodyHome(context: context);
  }

// body home
  Widget bodyHome(
      {double size, sizeWid, sizePadding, sizeBox, BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xffFEFEFE),
          ),
          height: 345,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    elevation: 1,
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xffF7F3FF),
                      ),
                      alignment: Alignment.center,
                      height: 80,
                      child: Image.network(
                        widget.model.thumbnailUrl,
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                    onTap: (){
                      FlutterClipboard.copy('hello flutter friends').then(( value ) {
                        setState(() {
                          hint = false;
                        });
                      });
                    },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        height: 80,
                        width: 100,
                        child: ClipPath(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            color:hint ?  Color(0xffFA511A) :Colors.grey,
                            alignment: Alignment.center,
                            child: Text(
                              'DE12F',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          clipper: CustomClipPath(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Container(
                  child: Text(
                widget.model.titleEn,
                style: TextStyle(
                  height: 1.5,
                  color: Color(0xff05003B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 23, left: 23, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.history,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last used',
                            style: TextStyle(
                                height: 1.2, color: Color(0xffB2B1B6)),
                          ),
                          Text(
                            "${TimeAgo.timeAgoSinceDate(widget.model.dateTime)}",
                            style: TextStyle(
                                height: 1.5, color: Color(0xff76757B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.date_range,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expires on ',
                            style: TextStyle(
                                height: 1.2, color: Color(0xffB2B1B6)),
                          ),
                          Text(
                            "${TimeAgo.timeAgoSinceDate(widget.model.dateTimeEnd)}",
                            style: TextStyle(
                                height: 1.2, color: Color(0xff76757B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 3,
                        child:InkWell(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewApp()));
                       },
                        child:Container(
                          alignment: Alignment.center,
                          height: 53,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff221D71),
                          ),
                          child: Text(
                            'SHOP NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 53,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF9E4D6),
                            ),
                            child: InkWell(
                              onTap: () async {
                                int co = widget.model.conter;
                                if (isFav) {
                                  print(co++);
                                  Firestore.instance
                                      .collection('items')
                                      .document(widget.model.id)
                                      .updateData({
                                    "conter": co++,
                                  });
                                  isFav = false;
                                } else {
                                  print(co--);
                                  Firestore.instance
                                      .collection('items')
                                      .document(widget.model.id)
                                      .updateData({
                                    "conter": co--,
                                  });
                                  setState(() {
                                    isFav = true;
                                  });
                                }
                              },
                              child: isFav
                                  ? Icon(
                                      Icons.favorite_outline_outlined,
                                      color: Color(0xffCD6645),
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Color(0xffCD6645),
                                    ),
                            ),
                          ),
                          Text(
                            "${widget.model.conter}",
                            style: TextStyle(color: Color(0xff949399)),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 53,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffECEAFE),
                            ),
                            child: InkWell(
                              onTap: (){
                                Share.share('Great picture');
                              },
                              child: FaIcon(
                                FontAwesomeIcons.telegramPlane,
                                color: Color(0xff807FD9),
                              ),
                            ),
                          ),
                          Text('Share',
                              style: TextStyle(
                                color: Color(0xff9E9DA3),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void like() async {}
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
