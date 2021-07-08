import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/body.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/change_product_avatar.dart';
import 'package:se346/components/image_button.dart';

import '../../../../constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key,}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

late DocumentSnapshot product;
//late String id;

class _AddProductScreenState extends State<AddProductScreen> {
  late DocumentSnapshot product;
  late String name = "";
  late num price = 0;
  late num amount = 0;
  late String describe = "", developers = "";
  late String imgSrc = "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-f6fa8.appspot.com/o/box.png?alt=media&token=cb48ee78-f3ef-434a-a5b6-1e9bf3a6c5b7";

  @override
  Widget build(BuildContext context) {
    CheckProduct();
    late GetImageProduct getImageProduct = new GetImageProduct(product);
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('product').where('name', isEqualTo: "").snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        return Scaffold(
          //resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top:0,
                    left:0,
                    child: ImageButton(icnSrc: "assets/icons/back.svg", press: (){
                      product.reference.delete();
                      AddProductCount = -1;
                      Navigator.pop(context);
                    }),),
                  Positioned(
                      top:size.height * 0.1,
                      left: size.width * 0.1,
                      right:size.width * 0.1,
                      height: size.height * 0.8,
                      child:SingleChildScrollView(
                          child:Column(
                            children: [
                              ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink.image(
                                    image: NetworkImage(product['imgSrc']),
                                    fit: BoxFit.cover,
                                    width: 128,
                                    height: 128,
                                    child: InkWell(onTap: () {
                                      getImageProduct.getImage(context);
                                    }),
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height*0.02,),
                              TextFieldEditor(label: "Name",
                                  text: "",
                                  onChanged: (value){
                                      name = value;
                                  }),
                              SizedBox(height: size.height*0.02,),
                              TextFieldEditor(
                                  label: "Amount",
                                  text: "",
                                  onChanged: (value){
                                      amount = num.parse(value);
                                  }),
                              SizedBox(height: size.height*0.02,),
                              TextFieldEditor(
                                  label: "Price",
                                  text: "",
                                  onChanged: (value){
                                      price = num.parse(value);
                                  }),
                              SizedBox(height: size.height*0.02,),
                              TextFieldEditor(
                                  label: "describe",
                                  text: "",
                                  onChanged: (value){
                                      describe = value;
                                  }),
                              SizedBox(height: size.height*0.02,),
                              TextFieldEditor(
                                  label: "Developers",
                                  text: "",
                                  onChanged: (value){
                                      developers = value;
                                  }),
                              SizedBox(height: size.height*0.02,),
                            ],
                          )
                      )
                  ),
                  Positioned(
                      bottom: 0,
                      child:Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              product.reference.update({
                                'name' : name,
                                'developers' : developers,
                                'price' : price,
                                'amount' : amount,
                                'describe' : describe,
                              });
                              Navigator.pop(context);
                            },
                            child: Text("Save"),
                            color: kPrimaryLightColor,
                            minWidth: size.width,
                            height: size.height*0.08,
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  Future AddProduct() async {
    AddProductCount = 0;
    FirebaseFirestore.instance.collection('product')
        .add({
      'amount': 0,
      'describe': "",
      'developers': "",
      'idProduct': 0,
      'imgSrc': imageDefault,
      'name': "",
      'price': 0,
      'searchKey': "",
      'stop': true,
      'sale' : 0
    }).whenComplete(() {
      FirebaseFirestore.instance.collection('product').where('name', isEqualTo: "")
          .snapshots()
          .listen((event) {
        product = event.docs[0];
      });
      AddProductCount = 1;
    });
  }

  Future CheckProduct() async {
    FirebaseFirestore.instance.collection('product')
        .where('name', isEqualTo: "").snapshots()
        .listen((event) {
      if(event.docs.isEmpty){
        if(AddProductCount == -1)
          AddProduct();
        return;
      }
      else{
        product = event.docs[0];
        return;
      }
    });
  }
}

