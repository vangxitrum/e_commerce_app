import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/Components/Change_avatar.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/Components/profile_widget.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/edit_screen.dart';
import 'package:se346/Screens/Welcome/welcome_screen.dart';
import 'package:se346/components/image_button.dart';

class Body extends StatefulWidget {
  final String avatarURL;
  const Body({
    required this.avatarURL,
    Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

Future signOut() async {
  try{
    await FirebaseAuth.instance.signOut();
  }catch(e){
    print(e);
  }
}

class _BodyState extends State<Body> {
  late String AvatarURL = widget.avatarURL;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: (){
              setState(() {
                Navigator.pop(context);
                signOut();
              });
            },
            minWidth: size.width,
            height: size.height * 0.08,
            color: Colors.lightBlueAccent,
            child: Text("Log out",style: TextStyle(fontSize: 18,color: Colors.white),),
          ),
        ],
      ),
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
                      imagePath: AvatarURL,
                      onClicked: () async {
                        await Navigator.push( context,
                          MaterialPageRoute(builder: (context) => EditScreen(avatarURL: widget.avatarURL,)),
                        );
                        //setState(() {if(avatarURL != "") AvatarURL = avatarURL;print("profile: " + AvatarURL);});
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    buildName(),
                  ],
                )
            ),
          ]
        ),
      )
    );
  }
}
