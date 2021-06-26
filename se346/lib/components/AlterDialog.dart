import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {

  late bool isContinue = true;

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      isContinue = false;
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
      isContinue = true;
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}