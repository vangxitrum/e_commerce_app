import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/order_info_screen.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/rounded_text.dart';
import 'package:se346/Screens/UserScreen/UserOrderInfo/user_order_info.dart';
import 'package:se346/components/rounded_containter.dart';
import 'package:intl/intl.dart';

class UserOrderItem extends StatefulWidget {
  final DocumentSnapshot order;
  const UserOrderItem({
    required this.order,
    Key? key}) : super(key: key);

  @override
  _UserOrderItemState createState() => _UserOrderItemState();
}

String dateTime(DateTime dt){
  String formattedDate = DateFormat('dd-MM-yyyy').format(dt);
  return formattedDate;
}

class _UserOrderItemState extends State<UserOrderItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
        return GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return UserOderInfo(order: widget.order,);
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
                            child: Column(
                              children: [
                                Text(widget.order['user_name'],textAlign: TextAlign.left, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height * 0.006,),
                                RoundedText(text: widget.order['status'],),
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
                            Text(DateFormat('dd-MM-yyyy').format(widget.order['time'].toDate()))
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
                            Text(widget.order.id)
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
                              Text(widget.order['total'].toString() + "\$")
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ],
          )
        );
    }
}