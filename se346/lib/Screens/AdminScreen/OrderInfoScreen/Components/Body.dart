import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/Components/buy_product.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/rounded_text.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/components/rounded_containter.dart';

class Body extends StatefulWidget {
  final List<Product> productList;
  const Body({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedStatus = "Waiting";
  List OrderStatus = ["Waiting","Cancel","Success"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
      height: size.height,
      width: double.infinity,
      color: Colors.white70,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ImageButton(
                    icnSrc: "assets/icons/back.svg",
                    press: (){
                      Navigator.pop(context);}),
              ],
            ),
            RoundedContainer(
              height: size.height * 0.23,
              width: size.width * 0.9,
              color: Colors.white,
              radius: 20,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.01),
                        child:
                        Column(
                          children: [
                            Text("Order Information",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: size.height * 0.006,),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: size.height * 0.006,),
                  Padding(
                    padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                    child:
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Contact "),
                        Text("User contact")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                    child:
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Orders "),
                        Text("Orders Time")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                    child:
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("Orders Code"),
                        Text("Orders Id")
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.01,),
                  Padding(
                    padding: EdgeInsets.only(left: size.height * 0.01,bottom: size.height * 0.005,right:size.height * 0.01),
                    child:
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("Order Status",style: TextStyle(fontWeight: FontWeight.bold,),),
                        DropdownButton(
                          value: selectedStatus,
                          onChanged: (newStatus){
                            setState(() {
                              selectedStatus = newStatus.toString();
                            });
                          },
                          items: OrderStatus.map((valueItem){
                            return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),  );
                        }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height *0.01,),
            Container(
              width: size.width,
              height: size.height * 0.6,
                child: ListView.builder(
                    itemCount: widget.productList.length,
                    itemBuilder: (context, index) {
                      return BuyProduct(amount: 2,product:widget.productList[index],);
                    }
                )
            ),
            SizedBox(height: size.height *0.025,),
            Padding(
              padding: EdgeInsets.only(left: size.width* 0.13,right: size.width* 0.13),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  Text("\$" + "200",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      )
      )
    );
  }
}


