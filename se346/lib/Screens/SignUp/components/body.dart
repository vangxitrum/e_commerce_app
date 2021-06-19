import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/Login/login_screen.dart';
import 'package:se346/Screens/SignUp/components/background.dart';
import 'package:se346/Screens/UserScreen/MainScreen/Components/Body.dart';
import 'package:se346/components/already_have_account_handler.dart';
import 'package:se346/components/rounded_button.dart';
import 'package:se346/components/rounded_password_field.dart';
import 'package:se346/components/rounded_user_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _Body createState() => _Body();
}
const String defaultAvatar = "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-f6fa8.appspot.com/o/89421820_p0.jpg?alt=media&token=bcad557c-b056-42bc-bf1b-d655a9744048";

class _Body extends State<Body>{
  late String username;
  late String password;
  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: username,
          password: password,
      ).then((value) {
        value.user!.updateDisplayName("User name");
        value.user!.updatePhotoURL(defaultAvatar);
        //AddOrder();
        return value;
      });

    } on FirebaseAuthException catch (e) {
      print("Error $e");
    } catch (e) {
      print("Error $e");
    }
    Navigator.pop(context);

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
                Navigator.pop(context);
                Navigator.of(context).push(
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
