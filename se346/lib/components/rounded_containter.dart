import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child;
  final double radius;
  const RoundedContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.child,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
          ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child: child,
    );
  }
}
