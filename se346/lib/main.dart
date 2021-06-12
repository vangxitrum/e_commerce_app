import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/Welcome/welcome_screen.dart';
import 'package:se346/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';
import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();
  final CollectionReference adminList = FirebaseFirestore.instance.collection('admin');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
              stream: auth.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.active) {
                  Object? user = snapshot.data;

                  if(user == null) {
                    return WelcomeScreen();
                  }
                  else {
                    return StreamBuilder(
                      stream: adminList.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasData){
                          print(snapshot.data!.docs.map((e) => Text(e['user'])));
                          //return ListView(
                            //children: snapshot.data!.docs.map((e) => ListTile(title: Text(e['user']),)).toList(),
                          //);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },);
                  }
                }

                return Scaffold(
                  body: Center(
                      child: Text("Loading...")
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
