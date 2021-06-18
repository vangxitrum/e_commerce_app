import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/rounded_containter.dart';

class BuyProduct extends StatelessWidget {
  final DocumentSnapshot orderInfo;
  final DocumentSnapshot product;
  const BuyProduct({
    Key? key,
    required this.orderInfo,
    required this.product
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.01,),
        RoundedContainer(
            height: size.height * 0.18,
            width: size.width * 0.9,
            color: Colors.white,
            radius: 20,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02,),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(product['imgSrc'],height: size.width * 0.17,width: size.width * 0.17,),
                      ),
                    ),
                    SizedBox(width: size.height * 0.01,),
                    Container(
                        width: size.width * 0.6,
                        height: size.height * 0.15,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['name'],style:TextStyle(fontSize: 27)),
                            SizedBox(width: size.height * 0.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$" + product['price'].toString()),
                                Text("x" + orderInfo['amount'].toString())
                              ],
                            ),
                            Divider(color: Colors.black54,thickness: 2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("subtotal"),
                                Text("\$" + (orderInfo['amount'] * product['price']).toString())
                              ],
                            ),
                          ],
                        )
                    )
                  ],
                )
              ]
            )
        )
      ],
    );
  }
}

