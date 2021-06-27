import 'package:flutter/material.dart';
import 'package:se346/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double w;
  final Color bgColor;
  const TextFieldContainer({
    Key? key,
    required this.w,
    required this.child,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: size.width * w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
