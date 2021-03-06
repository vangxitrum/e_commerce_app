import 'package:flutter/material.dart';
import 'package:se346/components/text_field_container.dart';
import 'package:se346/constants.dart';

class RoundedSearchField extends StatelessWidget {
  final String hindText;
  final IconData fieldIcon = Icons.search;
  final double w;
  final ValueChanged<String> onChanged;
  const RoundedSearchField({
    Key? key,
    required this.hindText,
    required this.onChanged,
    required this.w,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      bgColor: Colors.white24,
      w: w,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hindText,
          suffixIcon: Icon(
            fieldIcon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
