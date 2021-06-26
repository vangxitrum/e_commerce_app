import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/components/AlterDialog.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/constants.dart';


class Body extends StatefulWidget {
  final DocumentSnapshot product;
  Body({
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
  late String Developers = "";
  late String Describe = "";
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(_product['imgSrc'],height: size.width * 0.4,width: size.width * 0.4,),
              ),
            ),
          ),
          Positioned(
              top:size.height * 0.3,
              left: size.width * 0.1,
              right:size.width * 0.1,
              height: size.height * 0.6,

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
                            try {
                              Amount = int.parse(value);
                            } catch (e, s) {
                              print(s);
                            }
                          }),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(
                          label: "Price",
                          text: _product['price'].toString(),
                          onChanged: (value){
                            try {
                              Price = int.parse(value);
                            } catch (e, s) {
                              print(s);
                            }
                          }),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(
                          label: "Developers",
                          text: _product['developers'].toString(),
                          onChanged: (value){
                            Developers = value;
                          }),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(
                          label: "Describe",
                          text: _product['describe'].toString(),
                          onChanged: (value){
                            Describe = value;
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
                        'price' : Price != 0? Price : _product['price'],
                        'describe' : Describe != ""? Describe : _product['describe'],
                        'developers' : Developers != ""? Developers : _product['developers']
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
                      onPressed: (){
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
                      },
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

