import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/CartScreen/Components/Body.dart';

class CartInfoScreen extends StatefulWidget {
  final DocumentSnapshot order;
  const CartInfoScreen({
    required this.order,
    Key? key}) : super(key: key);

  @override
  _CartInfoScreenState createState() => _CartInfoScreenState();
}

class _CartInfoScreenState extends State<CartInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Body(order: widget.order,);
  }
}

