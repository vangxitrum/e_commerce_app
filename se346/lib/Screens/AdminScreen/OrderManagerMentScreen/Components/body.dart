import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('order').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
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
                  SizedBox(height: 0.02 * size.height,),
                  Container(
                      width: size.width * 0.9,
                      height: size.height * 0.6,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return OrderItem(order: snapshot.data!.docs[index]);
                          }
                      )
                  ),
                ],
              ),
            ),
        );
        }
        return Text("None");
      }
    );
  }
}
