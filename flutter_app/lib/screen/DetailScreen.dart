import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.lightBlueAccent,
     appBar: buildAppBar(context),
   );
  }

  Widget buildAppBar(BuildContext context){
    const double defaultSizeIcon = 25;
    return AppBar(
      leading: IconButton(
      icon: SvgPicture.asset("assets/icons/ic_back.svg",
        color: Colors.white,
        width: defaultSizeIcon,
        height: defaultSizeIcon,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
