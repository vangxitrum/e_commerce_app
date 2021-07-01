import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/SideMenu.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/oder_item.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/main.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    filteredList = menuItem;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('order').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          menuItem.clear();
          for(int i = 0; i < snapshot.data!.docs.length; i++){
            menuItem.add(snapshot.data!.docs[i]);
          }
          return Scaffold(
            key: _scaffoldKey,
            //drawer: SideMenu(),
            body: Container(
              width: size.width,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 0.05 * size.width,),
                    ScreenHeader(onChanged: (string){
                      filteredList.clear();
                      //print("menuItem: " + menuItem.length.toString());
                      setState(() {filteredList = snapshot.data!.docs.where(
                              (u) => (u['user_name'].toUpperCase().contains(string.toUpperCase()))).toList();
                      });
                    }, scaffoldKey: _scaffoldKey),
                    //SizedBox(height: 0.02 * size.height,),
                    Container(
                        width: size.width,
                        height: size.height * 0.75,
                        child: ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              print("order: " + filteredList[index].id);
                              return OrderItem(order: filteredList[index]);
                            }
                        )
                    ),
                  ],
                ),
              )
            ),
        );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }
}
