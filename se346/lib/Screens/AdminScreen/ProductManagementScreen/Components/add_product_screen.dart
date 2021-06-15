import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/components/image_button.dart';

import '../../../../constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                top:size.height * 0.25,
                left: size.width * 0.1,
                right:size.width * 0.1,
                height: size.height * 0.6,
                child:SingleChildScrollView(
                    child:Column(
                      children: [
                        SizedBox(height: size.height*0.02,),
                        TextFieldEditor(label: "Name",
                            text: "",
                            onChanged: (value){
                            }),
                        SizedBox(height: size.height*0.02,),
                        TextFieldEditor(
                            label: "Amount",
                            text: "",
                            onChanged: (value){
                            }),
                        SizedBox(height: size.height*0.02,),
                        TextFieldEditor(
                            label: "Price",
                            text: "",
                            onChanged: (value){

                            }),
                        SizedBox(height: size.height*0.02,),
                        TextFieldEditor(
                            label: "describe",
                            text: "",
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
                      onPressed: () {},
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
    );
  }
}
