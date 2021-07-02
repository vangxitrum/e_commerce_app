
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/AdminMainScreen/Components/sale_chart.dart';
import 'package:se346/Screens/AdminScreen/Components/SideMenu.dart';
import 'package:se346/Screens/AdminScreen/Components/screen_header.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/order_mangaerment_screen.dart';
import 'package:se346/components/rounded_containter.dart';
import 'package:se346/main.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

late List<Sale> data = [];
late double totalRevenue = 0;
late int waitingOrder = 0;

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final monthCount = 12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  List<Sale> getDataSale(List<DocumentSnapshot> list){
    List<Sale> listSale = [];
    waitingOrder = 0;
    totalRevenue = 0;
    for(int index = 0; index < DateTime.now().month; index++){
      late double total = 0;
      List<DocumentSnapshot> result = list.where((element) => (
          element['time'].toDate().month == index + 1 &&
          element['time'].toDate().year == DateTime.now().year
      )).toList();
      result.forEach((element) {
        total += double.parse(
          element['total'].toString()).round();
        if(element['status'] == "Waiting") waitingOrder++;
      });
      totalRevenue += total.round();
      listSale.add(Sale(total.round(), index + 1));
    }
    return listSale;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('order').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator()
          );
        data = getDataSale(snapshot.data!.docs);
        return Scaffold(
          key: _scaffoldKey,
          //drawer: SideMenu(),
          body: Container(
            height: size.height,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 0.03 * size.height,),
                //ScreenHeader(onChanged: (value){}, scaffoldKey: _scaffoldKey),
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
                              Text(totalRevenue.round().toString() + "\$",
                                style: TextStyle(fontSize: 20),)
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
                                Text(waitingOrder.toString(),
                                  style: TextStyle(fontSize: 20),)
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
    );
  }
}

