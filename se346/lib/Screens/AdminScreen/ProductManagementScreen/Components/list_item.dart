import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:se346/Screens/AdminScreen/ProductInfoScreen/product_info_screen.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_button.dart';


class ListItem extends StatefulWidget {
  final int index;
  const ListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    int _index = widget.index;
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
                              return ProductInfoScreen(index: _index);
                            }
                        )
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1/1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              filteredList[_index].imgSrc,
                            ),
                          ),
                        ),

                        AspectRatio(aspectRatio: 4/3,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: size.height * 0.015,),
                                Text(filteredList[_index].name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height * 0.01,),
                                Text("Amount: " + filteredList[_index].productAmount.toString()
                                ),
                                Text("Price: " + filteredList[_index].productPrice.toString()),
                              ],
                            )
                        ),
                        SizedBox(width: size.width*0.1,),
                      ],
                    )
                ),

                Row(
                  children: <Widget>[
                    Switch(value: menuItem[_index].setState,
                      onChanged: (bool newValue) {
                        setState(() {
                          menuItem[_index].setState = newValue;
                        });
                      },),
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          )
      );
  }
}

