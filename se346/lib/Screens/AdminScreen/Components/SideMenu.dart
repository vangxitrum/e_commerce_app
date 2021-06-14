import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se346/Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/order_mangaerment_screen.dart';
import 'package:se346/Screens/AdminScreen/ProductInfoScreen/product_info_screen.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/product_managerment_screen.dart';
import 'package:se346/constants.dart';

const String avatarURL = "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-f6fa8.appspot.com/o/avatar.png?alt=media&token=a8d5be3c-a233-466c-aae2-785ac05e741a";

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String username = FirebaseAuth.instance.currentUser!.email.toString();
    String photoURL =
      FirebaseAuth.instance.currentUser!.photoURL != null ?
      FirebaseAuth.instance.currentUser!.photoURL.toString() : avatarURL;
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
                      child: Image.network(photoURL)
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
                press: () {},
              ),
            ],
          ),
        ),
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
