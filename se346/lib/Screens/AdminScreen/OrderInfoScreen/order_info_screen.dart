import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/Components/Body.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({Key? key}) : super(key: key);

  @override
  _OrderInfoScreenState createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> list = [menuItem[0],menuItem[2],menuItem[0],menuItem[2]];
    return Body(productList: list,);
  }
}
