import 'package:flutter/material.dart';
import 'package:flutter_app/screen/Body.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget{
  static double defaultSizeIcon = 25;
  @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/ic_back.svg",
              color: Colors.white,
              width: defaultSizeIcon,
              height: defaultSizeIcon,),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset("assets/icons/ic_search.svg",
                color: Colors.white,
                width: defaultSizeIcon,
                height: defaultSizeIcon,),
              onPressed: () {},
            ),
            IconButton(
                icon: SvgPicture.asset("assets/icons/ic_cart.svg",
                  color: Colors.white,
                  width: defaultSizeIcon,
                  height: defaultSizeIcon,),
                onPressed: () {},
            ),
            SizedBox(width: 20,)
          ],
          title: Text("Icon"),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: Body(),
      );
  }
}