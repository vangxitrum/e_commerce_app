import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductInfoScreen/Components/body.dart';
import 'package:se346/components/image_button.dart';

class ProductInfoScreen extends StatelessWidget {
  final DocumentSnapshot product;
  const ProductInfoScreen({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(product: product),
    );
  }
}


