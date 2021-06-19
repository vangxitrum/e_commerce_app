import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/MainScreen/main_screen.dart';
import 'package:se346/Screens/Welcome/welcome_screen.dart';
import 'package:se346/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ban ty Game th',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: fbApp,
        builder: (context, snaphost) {
          if(snaphost.hasError){
            print ('you have an error! ${snaphost.hasError.toString()}');
            return Text('Something wrong!');
          }
          else if(snaphost.hasData) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.active) {
                  Object? user = snapshot.data;

                  if(user == null) {
                    return WelcomeScreen();   //  login screen
                  }
                  else {
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('admin').snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());

                          if(snapshot.data!.docs.where((element) => (
                            element['user'] == FirebaseAuth.instance.currentUser!.email
                          )).isEmpty)
                            return MainScreen();

                          return OverViewScreen();
                        });
                  }
                }
                return Scaffold(
                  body: Center(
                      child: CircularProgressIndicator()
                  ),
                );
              },
            );
              //;
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )

      //WelcomeScreen(),
    );
  }
}
