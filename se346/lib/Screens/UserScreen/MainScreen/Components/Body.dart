import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/Screens/UserScreen/Component/SideMenu.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/header.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/product_item.dart';
import 'package:se346/constants.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late MainScreenHeader header;
  int count = 0;
  @override
  void initState() {
    filteredList = menuItem;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('product').orderBy('name', descending: false).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            menuItem.clear();
            for(int i = 0; i < snapshot.data!.docs.length; i++){
              menuItem.add(snapshot.data!.docs[i]);
            }
            return Container(
              height: size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                child:Column(
                  children: <Widget>[
                    SizedBox(height: size.height*0.03,),
                    header = new MainScreenHeader(
                        scaffoldKey: _scaffoldKey,
                        onChanged: (string)  {
                          filteredList.clear();
                          //print("menuItem: " + menuItem.length.toString());
                          setState(() {filteredList = snapshot.data!.docs.where(
                                  (u) => (u['name'].toUpperCase().contains(string.toUpperCase()))).toList();
                          });
                        },
                        count: productCount,
                    ),
                    SizedBox(height: size.height*0.03,),
                    Container(
                      height: size.height * 0.84,
                      width: size.width,
                      child: GridView.builder(
                          itemCount: filteredList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(left:8,right: 8,top:4,bottom:4),
                                child: ProductItem(product: filteredList[index],onChanged: ()
                                {
                                  setState(() {
                                    productCount++;
                                  });
                                },)
                            );}),
                    ),
                    //ProductItem(name: "League of Legend",price: "100\$",img: "assets/images/lol.png",),
                  ],
                ),
              )
            );
          }
        )
    );
  }
}

List<List<String>> data = [
  ["League of Legend", "100\$", "assets/images/lol.png"],
  ["Test", "200\$", "assets/images/lol.png"],
  ["Test1", "200\$", "assets/images/lol.png"],
  ["League of Legend1", "100\$", "assets/images/lol.png"],
  ["League of Legend", "100\$", "assets/images/lol.png"],
  ["Test", "200\$", "assets/images/lol.png"],
  ["Test1", "200\$", "assets/images/lol.png"],
  ["League of Legend1", "100\$", "assets/images/lol.png"],
  ["League of Legend", "100\$", "assets/images/lol.png"],
  ["Test", "200\$", "assets/images/lol.png"],
  ["Test1", "200\$", "assets/images/lol.png"],
  ["League of Legend1", "100\$", "assets/images/lol.png"],
];