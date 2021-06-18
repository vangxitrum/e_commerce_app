import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/Screens/UserScreen/CartScreen/Components/user_buy_product.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_containter.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _tabController = new TabController(length: 2, vsync: this, initialIndex: 0)
    ..addListener(() {});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total: 200\$",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(width: size.width  * 0.1,),
            FlatButton(
              onPressed: (){
                setState(() {
                  //productCount++;
                });
              },
              minWidth: size.width * 0.5,
              height: size.height * 0.1,
              color: Colors.lightBlueAccent,
              child: Text("Confirm",style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
          ],
        ),
        body: Container(
            height: size.height,
            width: double.infinity,
            color: Colors.white70,
            child:Column(
                children: [
                  Row(
                    children: [
                      ImageButton(
                          icnSrc: "assets/icons/back.svg",
                          press: (){
                            Navigator.pop(context);}),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                    child: TabBar(
                      isScrollable: true,
                      indicatorPadding: EdgeInsets.all(10),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 20),
                      labelPadding:
                      EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                      indicator: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20)),
                          controller: _tabController,
                          tabs: [
                            Text('Information'),
                            Text('Cart'),]),
                    ),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Column(
                          children: [
                            TextFieldEditor(
                              label: 'Email',
                              text: "user email",
                              onChanged: (name) {},
                            ),
                            SizedBox(height: size.height * 0.03),
                            TextFieldEditor(
                              label: 'SDT',
                              text: 'xxx',
                              onChanged: (email) {},
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return UserBuyProduct(amount: 2,);
                          }
                      ),
                    ]),
                  )
        ])
    )
    );
  }
}
