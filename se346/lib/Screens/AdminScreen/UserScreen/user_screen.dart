import 'package:flutter/material.dart';

import 'Components/Body.dart';

class UserScreen extends StatefulWidget {
  final String avatarURL;
  const UserScreen({
    required this.avatarURL,
    Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Body(avatarURL: widget.avatarURL,);
  }
}
