import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/Components/Body.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/Body.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/constants.dart';

class Body extends StatefulWidget {
  final DocumentSnapshot product;
  const Body({
    required this.product,
    Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late int count = 0;
  late int total = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total: $total\$",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(width: size.width  * 0.1,),
          FlatButton(
              onPressed: () {
                if(count > 0) {
                  if(count <= widget.product["amount"]){
                    addCount = 0;
                    AddOrderInfo(count, widget.product.id, orderUnconfirmed.id);
                    orderUnconfirmed.reference.update({
                      'amount': orderUnconfirmed['amount'] + count,
                      'total' : orderUnconfirmed['total'] + widget.product['price'] * count
                    });
                    /*widget.product.reference.update({
                      'amount' : widget.product["amount"] - count
                    });*/
                    productCount += count;
                  }
                  else{
                  }
                }
                Navigator.pop(context);
              },
              minWidth: size.width * 0.5,
              height: size.height * 0.1,
              color: Colors.lightBlueAccent,
              child: Text("Add to cart",style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
        ],
      ),
      body: Container(
        height: size.height,
        width:  size.width,
        child: SingleChildScrollView(
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
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: size.height * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.product['imgSrc'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.1,),
                        Container(
                          width: size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                              Text(widget.product['developers'],style: TextStyle(color: Colors.black45,fontSize: 17),overflow: TextOverflow.ellipsis,maxLines: 2,),
                              Text(widget.product['price'].toString() + "\$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              Text("Số lượng trong kho: " + widget.product["amount"].toString(), style: TextStyle(fontSize: 20),),
                            ],
                          )
                        ),
                        SizedBox(height: size.height * 0.05,),
                        Row(
                          children: [
                            ImageButton(icnSrc: 'assets/icons/remove.svg', press: (){
                              setState(() {
                                if(count > 0) count--;
                            }); }),
                            Text(count.toString() ,style:TextStyle(fontSize: 30)),
                            ImageButton(icnSrc: 'assets/icons/add.svg', press: (){
                              setState(() {
                                if(count < widget.product["amount"]){
                                  count++;
                                  total = widget.product['price'].toInt() * count;
                                }
                              }); }),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Divider(color: Colors.black54,thickness: 2,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Text("Describe",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Text(
                      widget.product['describe']!,
                      maxLines: 10,
                      style: TextStyle(fontSize: 14,letterSpacing: 1.5),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
