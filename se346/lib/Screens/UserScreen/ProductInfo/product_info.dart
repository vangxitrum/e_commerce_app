import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/ProductInfo/Components/Body.dart';

class ProductInfo extends StatefulWidget {
  final DocumentSnapshot product;
  const ProductInfo({
    required this.product,
    Key? key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Body(product: widget.product,);
  }
}
