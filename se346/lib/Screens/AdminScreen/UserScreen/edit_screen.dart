import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/components/image_button.dart';

import 'Components/Change_avatar.dart';
import 'Components/profile_widget.dart';

class EditScreen extends StatefulWidget {
  final String avatarURL;
  late bool check = false;
  EditScreen({
    required this.avatarURL,
    Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late String AvatarURL = widget.avatarURL;
  late String name;
  late String email;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                      height: size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.03),
                            ProfileWidget(
                                    imagePath: AvatarURL,
                                    onClicked: () async {
                                      await getImage(context);
                                      //setState(() {AvatarURL = avatarURL == "" ? AvatarURL : avatarURL;});
                                    },
                                    isEdit: true,
                            ),
                            TextFieldEditor(
                                    label: 'Full Name',
                                    text: FirebaseAuth.instance.currentUser!.displayName!.toString(),
                                    onChanged: (value) {
                                      name = value;
                                    },
                                  ),
                            SizedBox(height: size.height * 0.03),
                            TextFieldEditor(
                                    label: 'Email',
                                    text: FirebaseAuth.instance.currentUser!.email!.toString(),
                                    onChanged: (value) {
                                      email = value;
                                    },
                                  ),
                            CheckboxListTile(
                                    title: Text("Change Password"),
                                    value: widget.check,
                                    onChanged: (bool? x){
                                      setState(() {
                                        widget.check = x == true ? true:false;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                  ),
                            SizedBox(height: size.height * 0.03),
                            Visibility(
                              visible: widget.check,
                              child: Column(
                                children: [
                                  TextFieldEditor(
                                    label: 'Current Password',
                                    text: "",
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  TextFieldEditor(
                                    label: 'New Password',
                                    text: "",
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  TextFieldEditor(
                                    label: 'Re-Password',
                                    text: "",
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                          ],
                        ),
                    ),
                ),
                Positioned(
                    bottom: 0,
                    child: FlatButton(
                      onPressed: (){
                        FirebaseAuth.instance.currentUser!.updateDisplayName(name);
                        Navigator.pop(context);
                        },
                      child: Text("Save", style: TextStyle(fontSize: 18,color: Colors.white)),
                      minWidth: size.width,
                      height: size.height * 0.08,
                      color: Colors.lightBlueAccent,
                    ))
              ],
            ),
          ),
    );
  }
}
