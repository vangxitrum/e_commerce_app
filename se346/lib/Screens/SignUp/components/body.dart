import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/Login/login_screen.dart';
import 'package:se346/Screens/SignUp/components/background.dart';
import 'package:se346/components/already_have_account_handler.dart';
import 'package:se346/components/rounded_button.dart';
import 'package:se346/components/rounded_password_field.dart';
import 'package:se346/components/rounded_user_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body>{
  late String username;
  late String password;
  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: username,
          password: password);
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
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RoundedUserField(
            hindText: "Your username",
            onChanged: (value) {username = value;},
          ),
          RoundedPasswordField(
            hindText: "Your password",
            onChanged: (value) {password = value;},
          ),
          RoundedPasswordField(hindText: "Confirm", onChanged: (value) {}),
          RoundedButton(text: "SIGN UP", press: _createUser),
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
