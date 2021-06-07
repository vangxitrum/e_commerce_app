import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/SideMenu.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/components/rounded_containter.dart';

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
      drawer: SideMenu(username: "User Name"),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 0.03 * size.height,),
            ScreenHeader(onChanged: (value){}, scaffoldKey: _scaffoldKey),
            SizedBox(height: 0.05 * size.height,),
            RoundedContainer(height: size.height * 0.3, width: size.width * 0.9, color: Colors.black12, child: Text("chart"), radius: 20),
            SizedBox(height: 0.03 * size.height,),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.05,left:size.width * 0.05 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedContainer(height: size.width * 0.4, width: size.width * 0.4, color: Colors.black12, child: Text("Sale"), radius: 20),
                  RoundedContainer(height: size.width * 0.4, width: size.width * 0.4  , color: Colors.black12, child: Text("Waiting Order"), radius: 20),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}

