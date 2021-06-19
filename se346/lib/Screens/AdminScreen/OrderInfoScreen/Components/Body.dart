import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/Components/buy_product.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/rounded_text.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/Screens/UserScreen/CartScreen/Components/user_buy_product.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_containter.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final DocumentSnapshot order;
  const Body({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

//late List<DocumentSnapshot> listProduct= [];
class _BodyState extends State<Body> {
  var listOrderProduct = [];
  String selectedStatus = "";
  List OrderStatus = ["Waiting","Cancel","Success","Unconfirmed"];

  Future getOrderInfo(AsyncSnapshot<QuerySnapshot> snapshot) async {
    listOrderProduct.clear();
    listOrderProduct = snapshot.data!.docs.where((u) => (
        u['idOrder'] == widget.order.id
    )).toList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStatus = widget.order['status'];
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('orderInfo').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          listOrderProduct.clear();
          listOrderProduct = snapshot.data!.docs.where((u) => (
              u['idOrder'] == widget.order.id
          )).toList();
          print(listOrderProduct.length);

          return Scaffold(
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
                                    Text(widget.order['user_name'])
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
                              SizedBox(height: size.height * 0.01,),
                              Padding(
                                padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                                child:
                                Row (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text("Order Status",style: TextStyle(fontWeight: FontWeight.bold,),),
                                    DropdownButton(
                                      value: selectedStatus,
                                      onChanged: (newStatus){
                                        setState(() {selectedStatus = newStatus.toString();});
                                        widget.order.reference.update({
                                          'status': newStatus.toString()
                                        });
                                      },
                                      items: OrderStatus.map((value){
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),  );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height *0.01,),
                        Container(
                            width: size.width,
                            height: size.height * 0.6,
                            child: ListView.builder(
                                itemCount: listOrderProduct.length,
                                itemBuilder: (context, index) {
                                  return UserBuyProduct(orderInfo: listOrderProduct[index]);
                                }
                            )
                        ),
                        SizedBox(height: size.height *0.025,),
                        Padding(
                          padding: EdgeInsets.only(left: size.width* 0.13,right: size.width* 0.13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                              Text("\$" + widget.order['total'].toString(), style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              )
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}


