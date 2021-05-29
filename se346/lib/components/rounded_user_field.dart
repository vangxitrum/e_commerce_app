import 'package:flutter/material.dart';
import 'package:se346/components/text_field_container.dart';
import 'package:se346/constants.dart';

class RoundedUserField extends StatelessWidget {
  final String hindText;
  final IconData fieldIcon = Icons.person;
  final ValueChanged<String> onChanged;
  const RoundedUserField({
    Key? key,
    required this.hindText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hindText,
          icon: Icon(
            fieldIcon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
