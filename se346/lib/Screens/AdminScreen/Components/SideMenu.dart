import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se346/Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/order_mangaerment_screen.dart';
import 'package:se346/Screens/AdminScreen/ProductInfoScreen/product_info_screen.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/product_managerment_screen.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/Components/Change_avatar.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/user_screen.dart';
import 'package:se346/constants.dart';


class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late String AvatarURL = FirebaseAuth.instance.currentUser!.photoURL!;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String username = FirebaseAuth.instance.currentUser!.displayName.toString();
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          return Drawer(
              child: Container(
                color: kMenuBGColor,
                child: SingleChildScrollView(
                  // it enables scrolling
                  child: Column(
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(color: Color.fromARGB(255, 171, 214, 223)),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                  radius: 30,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(FirebaseAuth.instance.currentUser!.photoURL!)
                                  )
                              ),
                            ),
                            SizedBox(height: size.height * 0.04,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:Text(username,style: TextStyle(color: kMenuTextColor, fontSize: 25), maxLines: 1,),
                            ),
                          ],
                        ),
                      ),
                      DrawerListTile(
                        title: "Overview",
                        svgSrc: "assets/icons/overview.svg",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return OverViewScreen();
                                  }
                              )
                          );
                        },
                      ),
                      SizedBox(height: size.height*0.02,),
                      DrawerListTile(
                        title: "Orders",
                        svgSrc: "assets/icons/order.svg",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return OrderManagementScreen();
                                  }
                              )
                          );
                        },
                      ),
                      SizedBox(height: size.height*0.02,),
                      DrawerListTile(
                        title: "Product Management",
                        svgSrc: "assets/icons/product.svg",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ProductManagementScreen();
                                  }
                              )
                          );
                        },
                      ),
                      SizedBox(height: size.height*0.02,),
                      DrawerListTile(
                        title: "Profile",
                        svgSrc: "assets/icons/profile.svg",
                        press: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return UserScreen(avatarURL: AvatarURL,);
                                  }
                              )
                          );
                          //setState(() {if(avatarURL != "") AvatarURL = avatarURL;});
                          print("Menu: " + AvatarURL);
                        },
                      ),
                    ],
                  ),
                ),
              )
          );
        }
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: kMenuTextColor,
        height: 20,
      ),
      title: Text(
        title,
        style: TextStyle(color: kMenuTextColor,fontSize: kMenuTextFont),
      ),
    );
  }
}
