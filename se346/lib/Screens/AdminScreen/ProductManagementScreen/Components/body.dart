import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/list_item.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/local_notification_service.dart';


import 'add_product_screen.dart';

const String imageDefault = "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-f6fa8.appspot.com/o/box.png?alt=media&token=cb48ee78-f3ef-434a-a5b6-1e9bf3a6c5b7";

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String idProduct = "";
  final String token = "ez9CnphmSW6etjk2urgv4Y:APA91bGtYdBTXraWIoy7Y6zygWGA1UPF5zYdDCBntH-Z4YI5Rkup5a6NiiyJLUPE34Z1KGdbrDRYVvl6WtCVhkjtCULEP-wB3JIMRWfZp7dcdZOVRCNCntARIVdFsxCXQ2upQhYsENKZ";


  @override
  void initState() {
    filteredList = menuItem;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("product").where('name', isNotEqualTo: "").orderBy("name", descending: false).snapshots(),
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
                height: size.height,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    //SizedBox(height: size.height*0.03,),
                    ScreenHeader(
                        scaffoldKey: _scaffoldKey,
                        onChanged: (string)  {
                          //print(string);
                          filteredList.clear();
                          //print("menuItem: " + menuItem.length.toString());
                          setState(() {filteredList = snapshot.data!.docs.where(
                                    (u) => (u['name'].toUpperCase().contains(string.toUpperCase()))).toList();
                            });
                          //print(filteredList.length);
                        }
                    ),
                    //SizedBox(height: size.height*0.05,),
                    Flexible(
                        child: Container(
                            height: size.height*0.8,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: filteredList.length,
                                itemBuilder: (context, index) {
                                  return ListItem(product: filteredList[index]);
                                }
                            )
                        )
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return AddProductScreen();
                                    }
                                )
                            );
                          },
                            icon: Icon(Icons.add)),
                        SizedBox(width: size.width * 0.024,),
                      ],
                    )
                  ],
                ),
              )
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }

}




