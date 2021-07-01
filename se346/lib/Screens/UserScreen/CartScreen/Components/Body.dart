import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/Components/text_field_editor.dart';
import 'package:se346/Screens/UserScreen/CartScreen/Components/user_buy_product.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/Body.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/constants.dart';

class Body extends StatefulWidget {
  final DocumentSnapshot order;
  const Body({
    required this.order,
    Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}
late List<DocumentSnapshot> listShow = [];
late List<DocumentSnapshot> listProduct = [];
late List<DocumentSnapshot> listOrderInfoShow = [];

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _tabController = new TabController(length: 2, vsync: this, initialIndex: 0)
    ..addListener(() {});

  late String email = widget.order['email'];
  late String numberPhone = widget.order['numberPhone'];

  @override
  void initState() {
    listShow = listOrderInfoShow;
    super.initState();
  }

  Future getOrderInfo(AsyncSnapshot<QuerySnapshot> snapshot) async {
    listOrderInfoShow.clear();
    listOrderInfoShow = snapshot.data!.docs.where((u) => (
        u['idOrder'] == widget.order.id
    )).toList();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    num total = widget.order['total'];
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('orderInfo').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData)
          return Scaffold(body: Center(child: CircularProgressIndicator()));

        getOrderInfo(snapshot);
        return Scaffold(
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Total: \$$total",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(width: size.width  * 0.1,),
                FlatButton(
                  onPressed: () async {
                    if(listOrderInfoShow.length > 0)
                    {
                      bool check = true;
                      listOrderInfoShow.forEach((order) {
                        FirebaseFirestore.instance.collection('product')
                            .doc(order['idProduct']).get().then((_product) {
                          if(_product['amount'] < order['amount'])
                            check = false;
                        });
                      });
                      if(check){
                        count = -1;
                        widget.order.reference.update({
                          'status': "Waiting",
                          'email': email,
                          'numberPhone': numberPhone
                        });
                        listOrderInfoShow.forEach((order) {
                          FirebaseFirestore.instance.collection('product')
                              .doc(order['idProduct']).get().then((_product) {
                            _product.reference.update({
                              'amount' : _product['amount'] - order['amount']
                            });
                          });
                        });
                      }
                      //productCount++;
                    };
                    Navigator.pop(context);
                  },
                  minWidth: size.width * 0.5,
                  height: size.height * 0.1,
                  color: Colors.lightBlueAccent,
                  child: Text("Confirm",style: TextStyle(fontSize: 18,color: Colors.white),),
                ),
              ],
            ),
            body: Container(
                height: size.height,
                width: double.infinity,
                color: Colors.white70,
                child:Column(
                    children: [
                      Row(
                        children: [
                          ImageButton(
                              icnSrc: "assets/icons/back.svg",
                              press: (){
                                Navigator.pop(context);}),
                        ],
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
                              Text('Information'),
                              Text('Cart'),]),
                      ),
                      Expanded(
                        child: TabBarView(
                            controller: _tabController, children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Column(
                              children: [
                                TextFieldEditor(
                                  label: 'Email',
                                  text: email,
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                                SizedBox(height: size.height * 0.03),
                                TextFieldEditor(
                                  label: 'SDT',
                                  text: numberPhone,
                                  onChanged: (value) {
                                    setState(() {
                                      numberPhone = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              itemCount: listOrderInfoShow.length,
                              itemBuilder: (context, index) {
                                print("menu: " + listShow.length.toString());
                                return UserBuyProduct(orderInfo: listOrderInfoShow[index]);
                              })
                        ]),
                      )
                    ])
            )
        );

      }
    );
  }
}
