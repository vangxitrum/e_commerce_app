import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/OrderManagerMentScreen/Components/body.dart';



class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({Key? key}) : super(key: key);

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
