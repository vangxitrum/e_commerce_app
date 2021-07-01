import 'package:flutter/material.dart';
import 'package:se346/components/text_field_container.dart';
import 'package:se346/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  bool _hide = true;
  final String hindText;
  final IconData fieldIcon = Icons.lock;
  final IconData subfixIcon = Icons.visibility;
  final ValueChanged<String> onChanged;
  RoundedPasswordField({
    Key? key,
    required this.hindText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      bgColor: kPrimaryLightColor,
      w: 0.8,
      child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hindText,
            icon: Icon(
              fieldIcon,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(subfixIcon, color: kPrimaryColor),
            border: InputBorder.none,
          ),
          obscureText: _hide),
    );
  }
}

/*class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  RoundedPasswordField({
    Key? key,
    required this.controller}) : assert(controller != null), super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _hide = false;
  final String hindText;
  final IconData fieldIcon = Icons.lock;
  final IconData subfixIcon = Icons.visibility;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {  
    return Container(
      child: child,
    );
  }
}*/
