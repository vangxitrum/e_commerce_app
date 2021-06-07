import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/list_item.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/constants.dart';


class Body extends StatefulWidget {
  final int index;

  const Body({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = widget.index;
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
                  image: AssetImage(menuItem[index].imgSrc),
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
                      TextFieldEditor(label: "Name", text:menuItem[index].productName, onChanged: (value){
                        menuItem[index].productName = value;
                      }),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(label: "Amount", text: menuItem[index].productAmount.toString(), onChanged: (value){}),
                      SizedBox(height: size.height*0.02,),
                      TextFieldEditor(label: "Price", text: menuItem[index].productPrice.toString() + '\$', onChanged: (value){}),
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
                    onPressed: (){},
                    child: Text("save"),
                    color: kPrimaryLightColor,
                    minWidth: size.width * 0.5,
                    height: size.height*0.08,
                  ),
                  FlatButton(
                      onPressed: (){},
                      child: Text("delete"),
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

