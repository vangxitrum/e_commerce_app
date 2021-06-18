import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/CartScreen/Components/user_buy_product.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_containter.dart';

class UserOderInfo extends StatefulWidget {
  UserOderInfo({Key? key}) : super(key: key);

  @override
  _UserOderInfoState createState() => _UserOderInfoState();
}

class _UserOderInfoState extends State<UserOderInfo> {
  String status = 'cancel';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar:
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: status == 'waiting' ? true : false,
              child: FlatButton(
              onPressed: (){
                setState(() {
                  //productCount++;
                });
              },
              minWidth: size.width,
              height: size.height * 0.065,
              color: Colors.lightBlueAccent,
              child: Text("Cancel",style: TextStyle(fontSize: 18,color: Colors.white),),

            ),)
          ],
        ),
        body: Container(
            height: size.height,
            width: double.infinity,
            color: Colors.white70,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      ImageButton(
                          icnSrc: "assets/icons/back.svg",
                          press: (){
                            Navigator.pop(context);}),
                    ],
                  ),
                  RoundedContainer(
                    height: size.height * 0.23,
                    width: size.width * 0.9,
                    color: Colors.white,
                    radius: 20,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.01),
                              child:
                              Column(
                                children: [
                                  Text("Order Information",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: size.height * 0.006,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.006,),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                          child:
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Contact "),
                              Text("UserName")
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                          child:
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Orders "),
                              Text("1/1/1990")
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                          child:
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Orders Code"),
                              Text("2")
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.01,),
                        Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                          child:
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Order Status",style: TextStyle(fontWeight: FontWeight.bold,),),
                              Text(status)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height *0.01,),
                  Container(
                      width: size.width,
                      height: status == 'waiting' ? size.height * 0.57 : size.height * 0.6,
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return UserBuyProduct(amount: 2,);
                          }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width* 0.13,right: size.width* 0.13, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                        Text("100\$"),
                      ],
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
