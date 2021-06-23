
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/user_screen.dart';
import 'package:se346/Screens/UserScreen/MainScreen/main_screen.dart';
import 'package:se346/Screens/UserScreen/OrderScreen/OrderScreen.dart';

class UserMainScreen extends StatefulWidget{
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController = new TabController(length: 3, vsync: this, initialIndex: 0)
    ..addListener(() {});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        color: Colors.white70,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: [
                    MainScreen(),
                    OrderScreen(),
                    UserScreen(avatarURL: FirebaseAuth.instance.currentUser!.photoURL!)
                  ]),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
              child: TabBar(
                  isScrollable: true,
                  indicatorPadding: EdgeInsets.all(10),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 20),
                  labelPadding:
                  EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                  indicator: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20)),
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home_filled),
                    ),
                    Tab(
                      icon: Icon(Icons.shopping_cart_outlined),
                    ),
                    Tab(
                      icon: Icon(Icons.account_circle_outlined),
                    )
                  ],
              ),
            ),
          ]
        ),
      )
    );
  }
}