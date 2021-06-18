import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/Screens/UserScreen/CartScreen/cart_info.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_search_field.dart';

class MainScreenHeader extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final void Function(String) onChanged;
  int count;
  MainScreenHeader({
    Key? key,
    required this.count,
    required this.scaffoldKey,
    required this.onChanged,
  }) : super(key: key);
  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<MainScreenHeader> {

  void test(){}

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = widget.scaffoldKey;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 0.1 * size.height,
      child:Row(
          children: <Widget>[
            ImageButton(icnSrc: "assets/icons/menu.svg", press: (){
              scaffoldKey.currentState!.openDrawer();
            }),
            RoundedSearchField(hindText: "Search here", onChanged: widget.onChanged,w:0.65),
            Stack(
              children: [
                IconButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return CartInfoScreen();
                          }
                      )
                  );
                },icon: Icon(Icons.shopping_cart_outlined)),
                Positioned(
                  top:0,
                  right: 3.5,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget.count !=0 ? Colors.red :Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child:Text(widget.count != 0 ? widget.count.toString():"",style: TextStyle(color: Colors.white),)
                  ),
                )
              ],
            )
          ]
      ),
    );
  }
}

