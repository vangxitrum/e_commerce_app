import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/AdminMainScreen/Components/sale_chart.dart';
import 'package:se346/Screens/AdminScreen/Components/SideMenu.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/order_mangaerment_screen.dart';
import 'package:se346/components/rounded_containter.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late List<Sale> data;
  final rng = Random();
  final monthCount = 12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final saleData = List<Sale>.generate(monthCount, (index){
       final amount = rng.nextInt(1000);
       final month = index+1;
       return Sale(amount,month);
    });
    setState(() {
      data = saleData;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(username: "User Name"),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 0.03 * size.height,),
            ScreenHeader(onChanged: (value){}, scaffoldKey: _scaffoldKey),
            SizedBox(height: 0.05 * size.height,),
            RoundedContainer(
                height: size.height * 0.35,
                width: size.width * 0.9,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.27,
                      width: size.width * 0.9,
                      child: SaleChart(saleData: data,),
                    ),
                    Text("Sale in month", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  ],
                ),
                radius: 20),
            SizedBox(height: 0.03 * size.height,),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.05,left:size.width * 0.05 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedContainer(height: size.width * 0.44, width: size.width * 0.44, color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: size.width * 0.04,),
                          Text("Total revenue",style: TextStyle(fontWeight: FontWeight.bold,fontSize:23)),
                          SizedBox(height: size.width * 0.1,),
                          Text("1000\$",style: TextStyle(fontSize: 20),)
                        ],
                      ),
                      radius: 20),
                  RoundedContainer(height: size.width * 0.44, width: size.width * 0.44  , color: Colors.white,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return OrderManagementScreen();
                                  }
                              )
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(height: size.width * 0.04,),
                            Text("Waiting Order",style: TextStyle(fontWeight: FontWeight.bold,fontSize:23)),
                            SizedBox(height: size.width * 0.1,),
                            Text("10",style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                      radius: 20),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}

