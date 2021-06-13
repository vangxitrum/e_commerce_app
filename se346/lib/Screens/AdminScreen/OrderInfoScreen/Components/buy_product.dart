import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/rounded_containter.dart';

class BuyProduct extends StatelessWidget {
  final DocumentSnapshot product;
  final int amount;
  const BuyProduct({
    Key? key,
    required this.product,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RoundedContainer(
        height: size.height * 0.18 ,
        width: size.width * 0.9,
        color: Colors.white,
        radius: 20,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:size.height * 0.02,left:size.height * 0.02),
              child:Row(
                children: [
                  Image.asset(product['imgSrc'], width: size.height * 0.08, height:size.height * 0.08,),
                  SizedBox(width: size.height * 0.01,),
                  Container(
                    width: size.width * 0.6,
                    height: size.height * 0.15,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product['productName'],style:TextStyle(fontSize: 27)),
                        SizedBox(width: size.height * 0.03,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$" + product['productPrice'].toString()),
                            Text("x" + amount.toString())
                          ],
                        ),
                        Divider(color: Colors.white,thickness: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("subtotal"),
                            Text("\$" + (amount * product['productPrice']).toString())
                          ],
                        ),
                      ],
                    )
                  )

                ],
              )
            )
          ],
        )

    );
  }
}
