import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback press;
  final String icnSrc;
  const ImageButton({
    Key? key,
    required this.icnSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white,
          ),
        shape: BoxShape.circle,
        ),
    child: SvgPicture.asset(
    icnSrc,
    height: 20,
    width: 20,
      ),
    ),
    );
  }
}
