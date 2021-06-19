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

  @override
  Widget build(BuildContext main_context) {
    Size size = MediaQuery.of(main_context).size;
    return Drawer(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            return Container(
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
                                    child: Image.network(
                                      FirebaseAuth.instance.currentUser!.photoURL!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: size.height * 0.04,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Text(FirebaseAuth.instance.currentUser!.displayName!,style: TextStyle(color: kMenuTextColor, fontSize: 25), maxLines: 1,),
                          ),
                        ],
                      ),
                    ),
                    DrawerListTile(
                      title: "Overview",
                      svgSrc: "assets/icons/overview.svg",
                      press: () {
                        Navigator.pop(main_context);
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
                        Navigator.pop(main_context);
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
                        Navigator.pop(main_context);
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
                                  return UserScreen(avatarURL: FirebaseAuth.instance.currentUser!.photoURL!,);
                                }
                            )
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        )
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
