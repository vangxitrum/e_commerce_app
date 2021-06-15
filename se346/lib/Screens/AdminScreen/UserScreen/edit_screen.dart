import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/components/image_button.dart';

import 'Components/Body.dart';
import 'Components/profile_widget.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
                top: size.height * 0.1,
                left: size.width * 0.1,
                right: size.width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      imagePath: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png",
                      onClicked: () {},
                      isEdit: true,
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFieldEditor(
                      label: 'Full Name',
                      text: "user name",
                      onChanged: (name) {},
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFieldEditor(
                      label: 'Password',
                      text: 'password',
                      onChanged: (email) {},
                    ),
                    SizedBox(height: size.height * 0.03),

                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
