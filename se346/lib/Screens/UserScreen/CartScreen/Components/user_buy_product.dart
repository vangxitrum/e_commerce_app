import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_containter.dart';

class UserBuyProduct extends StatefulWidget {
  final DocumentSnapshot orderInfo;
  UserBuyProduct({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  @override
  _UserBuyProductState createState() => _UserBuyProductState();
}
late List<DocumentSnapshot> _product = [];
late List<DocumentSnapshot> result = [];

class _UserBuyProductState extends State<UserBuyProduct> {
  Future getListProduct(AsyncSnapshot<QuerySnapshot> snapshot) async {
    _product.clear();
    _product = snapshot.data!.docs.where((element) => (
        element.id.toString() == widget.orderInfo['idProduct']
    )).toList();
  }
  num total = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('product').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        getListProduct(snapshot);

        //if(result.length == 0)
          //return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        //productInfo = result[0];
        if(_product.isEmpty){
          return Center(child: Text("Không có thông tin sản phẩm"));
        }
        else {
          print("length: " + _product.length.toString());
          return Column(
            children: [
              SizedBox(height: size.height * 0.008,),
              RoundedContainer(
                  height: size.height * 0.22,
                  width: size.width * 0.92,
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
                                child: Image.network(
                                  _product[0]['imgSrc'],
                                  height: size.width * 0.17,
                                  width: size.width * 0.17,
                                ),
                              ),
                            ),
                            SizedBox(width: size.height * 0.01,),
                            Container(
                                width: size.width * 0.6,
                                height: size.height * 0.18,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_product[0]['name'],style:TextStyle(fontSize: 27)),
                                    SizedBox(width: size.height * 0.03,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('\$'+(_product[0]['price']* (100 - _product[0]['sale'])/100).toString()),
                                        Text("x" + widget.orderInfo['amount'].toString())
                                      ],
                                    ),
                                    Divider(color: Colors.black54,thickness: 2,),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("subtotal"),
                                            Text("\$"+(_product[0]['price']* (100 - _product[0]['sale'])/100 * widget.orderInfo['amount']).toString()   ) // cho nay dung sum.tostring nay :v dung cai sum de tong don hang cho de
                                          ],
                                        ),
                                        SizedBox(height: size.height *0.005,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(onPressed: (){}, icon: Icon(Icons.delete),iconSize: 20,) ,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(onPressed: (){}, icon: Icon(Icons.remove),iconSize: 20,) ,
                                                IconButton(onPressed: (){}, icon: Icon(Icons.add),iconSize: 20,),


                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    )
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
    );;
  }
}
