
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'package:se346/Screens/AdminScreen/UserScreen/user_screen.dart';
import 'package:se346/Screens/UserScreen/OrderScreen/OrderScreen.dart';
import 'package:se346/components/my_flutter_app_icons.dart';

import 'OrderManagerMentScreen/order_mangaerment_screen.dart';
import 'ProductManagementScreen/product_managerment_screen.dart';

class AdminMainScreen extends StatefulWidget{
  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController = new TabController(length: 4, vsync: this, initialIndex: 0)
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
                        OverViewScreen(),
                        OrderManagementScreen(),
                        ProductManagementScreen(),
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
                        icon: Icon(Icons.article_outlined),
                      ),
                      Tab(
                        icon: Icon(MyFlutterApp.box),
                      ),
                      Tab(
                        icon: Icon(MyFlutterApp.boxes),
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