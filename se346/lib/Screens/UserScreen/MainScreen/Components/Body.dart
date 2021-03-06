import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/Screens/UserScreen/Component/SideMenu.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/caroucel_with_dots.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/header.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/product_item.dart';
import 'package:se346/constants.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}
late List<DocumentSnapshot> result = [];
late List<DocumentSnapshot> item = [];
late List<DocumentSnapshot> filter = [];
late DocumentSnapshot orderUnconfirmed;

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late MainScreenHeader header;
  @override
  void initState() {
    filter = item;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('order').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot_order) {
        if(!snapshot_order.hasData)
          return Center(child: CircularProgressIndicator(),);

        CheckOrder();

        result.clear();
        for(int i = 0; i < snapshot_order.data!.docs.length; i++) {
          if(snapshot_order.data!.docs[i]['idUser'] == FirebaseAuth.instance.currentUser!.uid &&
              snapshot_order.data!.docs[i]['status'] == Unconfirmed)
          result.add(snapshot_order.data!.docs[i]);
        }

        /*result = snapshot_order.data!.docs.where((element) => (
            element['idUser'] == FirebaseAuth.instance.currentUser!.uid &&
                element['status'] == Unconfirmed
        )).toList();*/

        if(result.length == 0) {
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          orderUnconfirmed = result[0];
          productCount = orderUnconfirmed['amount'];
          print(orderUnconfirmed.id);
          return Scaffold(
              key: _scaffoldKey,
              //drawer: SideMenu(),
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('product').where('name', isNotEqualTo: "").where('stop', isEqualTo: true).orderBy('name', descending: false).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
                    else{
                      item.clear();
                      for(int i = 0; i < snapshot.data!.docs.length; i++){
                        item.add(snapshot.data!.docs[i]);
                      }
                      return Container(
                          height: size.height,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child:Column(
                              children: <Widget>[
                                SizedBox(height: size.height*0.03,),
                                header = new MainScreenHeader(
                                  scaffoldKey: _scaffoldKey,
                                  onChanged: (string)  {
                                    //filter.clear();
                                    //print("menuItem: " + menuItem.length.toString());
                                    setState(() {filter = snapshot.data!.docs.where(
                                            (u) => ((u['stop'] == true)&&u['name'].toUpperCase().contains(string.toUpperCase()))).toList();
                                    });
                                  },
                                  count: productCount,
                                  order: orderUnconfirmed,
                                ),
                                //SizedBox(height: size.height*0.03,),

                                Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.32,
                                      width: size.width,
                                      child: CarouselWithDotsPage(imgList: ['https://gamek.mediacdn.vn/133514250583805952/2021/5/20/-16214825828142048416160.jpg','https://upload.motgame.vn/photos/motgame-vn/2021/03/lmht-quay-11-5-cung-ezreal-khong-than-thoai-cua-cac-cao-thu-han-01.jpg'],)
                                    ),
                                    Container(
                                      height: size.height * 0.48,
                                      width: size.width,
                                      child: GridView.builder(
                                          itemCount: filter.length,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding: EdgeInsets.only(left:8,right: 8,top:4,bottom:4),
                                                child: ProductItem(product: filter[index],onChanged: ()
                                                {
                                                  if(filter[index]['amount'] >= 1){
                                                    addCount = 0;
                                                    AddOrderInfo(1, filter[index], orderUnconfirmed.id);
                                                    num sale = filter[index]['sale'];
                                                    orderUnconfirmed.reference.update(
                                                        {
                                                          'amount': orderUnconfirmed['amount'] + 1,
                                                          'total' : orderUnconfirmed['total'] + filter[index]['price'] * (1 - (sale <= 1? sale : sale/100))
                                                        });
                                                    setState(() {
                                                      productCount++;
                                                    });
                                                    /*filter[index].reference.update(
                                                  {
                                                    'amount' : filter[index]['amount'] - 1
                                                  });*/
                                                  }
                                                },)
                                            );}),


                                    ),
                                  ],
                                )
                                //ProductItem(name: "League of Legend",price: "100\$",img: "assets/images/lol.png",),
                              ],
                            ),
                          )
                      );
                    }
                  }
              )
          );
        }
      }
    );
  }
}

Future<void> AddOrder() async {
  count = 0;
    await FirebaseFirestore.instance.collection('order').add({
      'amount' : 0,
      'email' : FirebaseAuth.instance.currentUser!.email,
      'idUser' : FirebaseAuth.instance.currentUser!.uid,
      'numberPhone' : "",
      'status': 'Unconfirmed',
      'time' : Timestamp.now(),
      'total' : 0,
      'user_name' : FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email,
    }).whenComplete(() => count = 1);
}

CollectionReference orderInfo = FirebaseFirestore.instance.collection('orderInfo');
Future<void> AddOrderInfo(int amount, DocumentSnapshot Product, String idOrder) async {
  List<DocumentSnapshot> result = [];
  orderInfo
      .snapshots().listen((event) {

        result = event.docs.where((element) => (
            element['idOrder'] == idOrder &&
                element['idProduct'] == Product.id
        )).toList();

        if(result.isEmpty){
          if(addCount == 0)
            addInfo(amount, Product, idOrder);
          return;
        }
        else{
          if(addCount == 0)
            updateOrderInfo(result[0], amount);
          return;
        }
  });
}


Future<void> addInfo(int amount, DocumentSnapshot Product, String idOrder){
  addCount++;
  return orderInfo.add({
    'amount' : amount,
    'idProduct' : Product.id,
    'idOrder' : idOrder,
    'sale' : Product['sale']
  });
}
Future<void> updateOrderInfo(DocumentSnapshot result, num amount) {
  addCount++;
  return orderInfo
      .doc(result.id)
      .update({'amount' : result['amount'] + amount})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

void CheckOrder(){
  List<DocumentSnapshot> result = [];
  FirebaseFirestore.instance.collection('order')
      .snapshots()
      .listen((event) {
        result = event.docs.where((element) => (
          element['idUser'] == FirebaseAuth.instance.currentUser!.uid
          && element['status'] == 'Unconfirmed'
        )).toList();
        if(result.length == 0){
          if(count == -1){
            AddOrder();
          }
          return;
        }
  });
}