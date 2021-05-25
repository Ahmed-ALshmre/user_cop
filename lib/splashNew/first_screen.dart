import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';

class RouteExample extends StatefulWidget {
  @override
  _RouteExampleState createState() => _RouteExampleState();
}

class _RouteExampleState extends State<RouteExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page1(),
    );
  }
}
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
//      appBar: AppBar(title: Text("Page 1")),
      body: Center(
        child: MaterialButton(
          child: Text("Next"),
          onPressed: () {
            Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
              return Page2();
            }));
          },
        ),
      ),
    );
  }
}
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
//      appBar: AppBar(title: Text("Page 2")),
      body: InkWell(
        onTap: (){
          Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
            return Page3();
          }));
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                  color: Colors.black
            ),
            child: Icon(Icons.arrow_forward_ios_outlined),
          )
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
//      appBar: AppBar(title: Text("Page 2")),
      body: Center(
        child: MaterialButton(
          child: Text("Back"),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}