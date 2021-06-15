import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/order_info_screen.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/rounded_text.dart';
import 'package:se346/components/rounded_containter.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final DocumentSnapshot order;

  const OrderItem({
    required this.order,
    Key? key}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

String dateTime(DateTime dt){
  String formattedDate = DateFormat('dd-MM-yyyy').format(dt);
  return formattedDate;
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot _order = widget.order;
    Size size = MediaQuery.of(context).size;
        return GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return OrderInfoScreen(order: widget.order,);
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
                                Text(_order['user_name'],textAlign: TextAlign.left, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height * 0.006,),
                                RoundedText(text:_order['status']),
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
                            Text(dateTime(_order['time'].toDate()))
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
                            Text(_order['id'].toString())
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
                              Text(_order['total'].toString())
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