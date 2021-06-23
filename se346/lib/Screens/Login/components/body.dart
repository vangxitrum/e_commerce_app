import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/Login/components/background.dart';
import 'package:se346/Screens/SignUp/sign_up_screen.dart';
import 'package:se346/Screens/Welcome/welcome_screen.dart';
import 'package:se346/components/already_have_account_handler.dart';
import 'package:se346/components/rounded_button.dart';
import 'package:se346/components/rounded_password_field.dart';
import 'package:se346/components/rounded_user_field.dart';
import 'package:se346/components/text_field_container.dart';
import 'package:se346/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _Body createState() => _Body();
}
class _Body extends State<Body> {
  late String username;
  late String password;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    } catch (e) {
      print("Error $e");
    }
    Navigator.of(context).pop();
  }
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
            onChanged: (value) {username = value;},
          ),
          RoundedPasswordField(
            hindText: "Your password",
            onChanged: (value) {password = value;},
          ),
          RoundedButton(
            text: "LOGIN",
            press: _login,
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AlreadyHaveAccountHandler(press: () {
                Navigator.pop(context);
                Navigator.of(context).push(
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
