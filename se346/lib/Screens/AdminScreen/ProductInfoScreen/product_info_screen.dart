import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductInfoScreen/Components/body.dart';
import 'package:se346/components/image_button.dart';

class ProductInfoScreen extends StatelessWidget {
  final int index;
  const ProductInfoScreen({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(index: index),
    );
  }
}


