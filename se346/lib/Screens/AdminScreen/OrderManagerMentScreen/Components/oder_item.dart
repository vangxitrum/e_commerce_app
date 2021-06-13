import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/order_info_screen.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/rounded_text.dart';
import 'package:se346/components/rounded_containter.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('order').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData)
        return GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return OrderInfoScreen();
                    }
                )
            );
          },
          child: Column(
            children: [
              SizedBox(height: size.height * 0.01,),
              RoundedContainer(
                  height: size.height * 0.17,
                  width: size.width * 0.9,
                  color: Colors.white,
                  radius: 20  ,
                  child:
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(size.height * 0.01),
                            child:
                            Column(
                              children: [
                                Text(snapshot.data!.docs[0]['user_name'],textAlign: TextAlign.left, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height * 0.006,),
                                RoundedText(text:"Success"),
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
                            Text("Orders "),
                            Text("Orders Time")
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
                            Text("Orders Id")
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                          child:
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total"),
                              Text("Order cost")
                            ],
                          )
                      ),



                    ],
                  )
              ),
            ],
          )
        );
        return Text("None Data");
      }
    );
  }
}