import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderInfoScreen/Components/Body.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/testData.dart';

class OrderInfoScreen extends StatefulWidget {
  final DocumentSnapshot order;
  const OrderInfoScreen({
    required this.order,
    Key? key}) : super(key: key);

  @override
  _OrderInfoScreenState createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Body(order: widget.order,);
  }
}
