import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/SideMenu.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/list_item.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_search_field.dart';
import 'package:se346/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //filteredList = menuItem;
  }

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
         children: <Widget>[
           SizedBox(height: size.height*0.03,),
           ScreenHeader(
             scaffoldKey: _scaffoldKey,
             onChanged: (string){
                bool x;
                x = menuItem[0].productName.contains(string);
                setState(() {filteredList = menuItem.where(
                  (u) => (u.productName.toLowerCase().contains(string.toLowerCase()))).toList();
                int y = filteredList.length;
                y;
            });}
           ),
           SizedBox(height: size.height*0.05,),
           Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('product').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasData){
                    return Container(
                        height: size.height*0.75,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return ListItem(product: snapshot.data!.docs[index]);
                            }
                        )
                    );
                  }
                  return Scaffold(
                    body: Center(
                      child: Text("Text"),
                    ),
                  );
                }
              )
            )
         ],
       ),
      )
    );
  }
}




