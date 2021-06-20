import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/UserScreen/Component/SideMenu.dart';
import 'package:se346/Screens/UserScreen/OrderScreen/components/oder_item.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('order').where('idUser', isEqualTo: user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
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
                            height: size.height * 0.865,
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return UserOrderItem(order: snapshot.data!.docs[index]);
                                }
                            )
                        ),
                      ],
                    ),
                  )
              ),
            );
          }
          return Text("None");
        }
    );
  }
}
