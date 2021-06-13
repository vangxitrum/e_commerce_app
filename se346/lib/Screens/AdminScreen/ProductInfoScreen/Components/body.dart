import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/constants.dart';


class Body extends StatefulWidget {
  final DocumentSnapshot product;

  const Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String Name = "";
  late int Amount = 0;
  late int Price = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DocumentSnapshot _product = widget.product;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top:0,
            left:0,
            child: ImageButton(icnSrc: "assets/icons/back.svg", press: (){
              Navigator.pop(context);
            }),),
          Positioned(
            top:size.height * 0.1,
            left:size.width * 0.31,
            right: size.width * 0.31,
            child:
            Container(
              height: size.height*0.2,
              width: size.height*0.2,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_product['imgSrc'],),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top:size.height * 0.3,
              left: size.width * 0.1,
              right:size.width * 0.1,
              height: size.height * 0.5,

              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(label: "Name",
                          text: _product['name'],
                          onChanged: (value){
                            Name = value;
                            print(Name);
                          }),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(
                          label: "Amount",
                          text: _product['amount'].toString(),
                          onChanged: (value){
                            Amount = int.parse(value);
                          }),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(
                          label: "Price",
                          text: _product['price'].toString(),
                          onChanged: (value){

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
                      print(Name);
                      _product.reference.update({
                        'name': Name != ""? Name : _product['name'],
                        'amount' : Amount != 0? Amount : _product['amount'],
                        'price' : Price != 0? Price : _product['price']
                      }).then((value) => print("User Updated"))
                        .catchError((error) => print("Failed to update user: $error"));
                      Navigator.of(context).pop();
                    },
                    child: Text("Save"),
                    color: kPrimaryLightColor,
                    minWidth: size.width * 0.5,
                    height: size.height*0.08,
                  ),
                  FlatButton(
                      onPressed: (){},
                      child: Text("Delete"),
                      minWidth: size.width * 0.5,
                      height: size.height*0.08
                  ),
                ],
              )
          )

        ],
      ),
    );
  }
}

