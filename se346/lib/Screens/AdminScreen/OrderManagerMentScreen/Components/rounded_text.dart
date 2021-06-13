import 'package:flutter/material.dart';

class RoundedText extends StatelessWidget {
  final String text;
  const RoundedText({
    Key? key,
    required this.text
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.024,
      width: size.width * 0.22                                            ,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))
      ),
      child: Text(text,textAlign: TextAlign.center,),
    );
  }
}
