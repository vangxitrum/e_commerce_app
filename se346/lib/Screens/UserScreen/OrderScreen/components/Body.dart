import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/UserScreen/Component/SideMenu.dart';
import 'package:se346/Screens/UserScreen/OrderScreen/components/oder_item.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 0.03 * size.width,),
                ScreenHeader(onChanged: (value){}, scaffoldKey: _scaffoldKey),
                SizedBox(height: 0.02 * size.height,),
                Container(
                    width: size.width * 0.9,
                    height: size.height * 0.6,
                    child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return UserOrderItem();
                        }
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}
