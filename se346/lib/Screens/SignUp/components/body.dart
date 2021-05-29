import 'package:flutter/material.dart';
import 'package:se346/Screens/Login/login_screen.dart';
import 'package:se346/Screens/SignUp/components/background.dart';
import 'package:se346/components/already_have_account_handler.dart';
import 'package:se346/components/rounded_button.dart';
import 'package:se346/components/rounded_password_field.dart';
import 'package:se346/components/rounded_user_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RoundedUserField(
            hindText: "Your username",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hindText: "Your password",
            onChanged: (value) {},
          ),
          RoundedPasswordField(hindText: "Confirm", onChanged: (value) {}),
          RoundedButton(text: "SIGN UP", press: () {}),
          SizedBox(height: size.height * 0.1),
          AlreadyHaveAccountHandler(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              }),
        ],
      )),
    );
  }
}
