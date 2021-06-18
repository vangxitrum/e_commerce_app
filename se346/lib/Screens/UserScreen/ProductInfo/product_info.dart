import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/ProductInfo/Components/Body.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
