import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/SideMenu.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/oder_item.dart';
import 'package:se346/main.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Container(
        width: size.width,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 0.03 * size.width,),
            ScreenHeader(onChanged: (value){}, scaffoldKey: _scaffoldKey),
            SizedBox(height: 0.05 * size.width,),
            OrderItem(),
          ],
        ),
      ),

    );
  }
}
