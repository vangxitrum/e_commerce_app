import 'package:flutter/material.dart';
import 'package:se346/Screens/Login/login_screen.dart';
import 'package:se346/Screens/SignUp/sign_up_screen.dart';
import 'package:se346/Screens/Welcome/components/background.dart';
import 'package:se346/components/rounded_button.dart';
import 'package:se346/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Cung cap chieu cao va chieu rong cua man hinh
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome to Ecommerce",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.05),
          RoundedButton(
              text: "LOGIN",
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
          RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }),
                );
              }),
        ],
      ),
    );
  }
}
