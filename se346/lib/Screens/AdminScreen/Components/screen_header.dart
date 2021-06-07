import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_search_field.dart';

/*class ScreenHeader extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ScreenHeader({Key? key,
  required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 0.1 * size.height,
      child:Row(
          children: <Widget>[
            ImageButton(icnSrc: "assets/icons/menu.svg", press: (){
              scaffoldKey.currentState!.openDrawer();
            }),
            SizedBox(width: size.width*0.07,),
            RoundedSearchField(hindText: "Search here", onChanged: (value){

            })
          ]
      ),
    );
  }
}
*/
class ScreenHeader extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final void Function(String) onChanged;
  const ScreenHeader({
    Key? key,
    required this.onChanged,
    required this.scaffoldKey
  }) : super(key: key);

  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
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
            SizedBox(width: size.width*0.07,),
            RoundedSearchField(hindText: "Search here", onChanged: widget.onChanged)
          ]
      ),
    );
  }
}

