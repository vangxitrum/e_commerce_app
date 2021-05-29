import 'package:flutter/material.dart';
import 'package:se346/Screens/Login/components/background.dart';
import 'package:se346/Screens/SignUp/sign_up_screen.dart';
import 'package:se346/components/already_have_account_handler.dart';
import 'package:se346/components/rounded_button.dart';
import 'package:se346/components/rounded_password_field.dart';
import 'package:se346/components/rounded_user_field.dart';
import 'package:se346/components/text_field_container.dart';
import 'package:se346/constants.dart';

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
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RoundedUserField(
            hindText: "User",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hindText: "Your password",
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {},
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AlreadyHaveAccountHandler(press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      )),
    );
  }
}
