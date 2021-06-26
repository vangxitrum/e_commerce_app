import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:se346/Screens/AdminScreen/ProductInfoScreen/product_info_screen.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_button.dart';


class ListItem extends StatefulWidget {
  final DocumentSnapshot product;
  const ListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot _product = widget.product;
    Size size = MediaQuery.of(context).size;
    return Container(
          height: size.height * 0.1,
          width: double.infinity,
          margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))
          ),
          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return ProductInfoScreen(product: _product);
                            }
                        )
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1/1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(_product['imgSrc'],height: size.width * 0.3,width: size.width * 0.3,),
                            ),
                          )
                        ),

                        AspectRatio(aspectRatio: 4/3,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: size.height * 0.015,),
                                Text(_product['name'],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height * 0.01,),
                                Text("Amount: " + _product['amount'].toString()),
                                Text("Price: " + _product['price'].toString()),
                              ],
                            )
                        ),
                        SizedBox(width: size.width*0.1,),
                      ],
                    )
                ),

                Row(
                  children: <Widget>[
                    Switch(value: _product['stop'],
                      onChanged: (bool newValue) {
                        _product.reference.update({
                          'stop': newValue
                        });
                      },),
                    IconButton(onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Notice"),
                              content: Text("Bạn có chắc muốn xóa sản phẩm"),
                              actions: [
                                FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel")),
                                FlatButton(
                                    onPressed: (){
                                      _product.reference.delete();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Continue")),
                              ],
                            );
                          });
                      }, icon: Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          )
      );
  }
}

