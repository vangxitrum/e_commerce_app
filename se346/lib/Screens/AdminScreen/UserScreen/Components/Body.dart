import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/Components/profile_widget.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/edit_screen.dart';
import 'package:se346/components/image_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
              top: size.height * 0.3,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileWidget(
                    imagePath: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png",
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditScreen()),
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  buildName(),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
