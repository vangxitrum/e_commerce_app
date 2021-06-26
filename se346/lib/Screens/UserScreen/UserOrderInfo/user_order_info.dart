import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/CartScreen/Components/user_buy_product.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_containter.dart';
import 'package:intl/intl.dart';
import 'package:se346/constants.dart';

class UserOderInfo extends StatefulWidget {
  final DocumentSnapshot order;
  UserOderInfo({
    required this.order,
    Key? key}) : super(key: key);

  @override
  _UserOderInfoState createState() => _UserOderInfoState();
}

class _UserOderInfoState extends State<UserOderInfo> {
  //String status = 'cancel';
  var listOrderProduct = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('orderInfo').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData)
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        listOrderProduct.clear();
        listOrderProduct = snapshot.data!.docs.where((u) => (
            u['idOrder'] == widget.order.id
        )).toList();
        return Scaffold(
            bottomNavigationBar:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: widget.order['status'] == 'Waiting' ? true : false,
                  child: FlatButton(
                    onPressed: (){
                      countCancel = -1;
                      widget.order.reference.update({
                        'status': 'Cancel'
                      }).whenComplete(() {
                        countCancel = 1;
                      });
                      if(countCancel == -1){
                        CancelOrder();
                      }
                      Navigator.pop(context);
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
                                  Text(widget.order['status'])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height *0.01,),
                      Container(
                          width: size.width,
                          height: widget.order['status'] == 'waiting' ? size.height * 0.57 : size.height * 0.6,
                          child: ListView.builder(
                                    itemCount: listOrderProduct.length,
                                    itemBuilder: (context, index) {
                                      return UserBuyProduct(orderInfo: listOrderProduct[index]);
                                    }
                                )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width* 0.13,right: size.width* 0.13, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            Text(widget.order['total'].toString() + "\$"),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
        );
      }
    );
  }
  Future CancelOrder() async {
    countCancel = 0;
    FirebaseFirestore.instance.collection('orderInfo')
        .where('idOrder', isEqualTo: widget.order.id)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        countCancel = 0;
        FirebaseFirestore.instance.collection('product')
            .doc(element['idProduct']).snapshots()
            .listen((event) {
              if(countCancel == 0){
                countCancel = 2;
                event.reference.update({
                  'amount' : event['amount'] + element['amount'],
                });
              }
              return;
        });
      });
    });
  }
}
