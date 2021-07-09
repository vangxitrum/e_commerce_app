
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/admin_screen.dart';
import 'package:se346/Screens/Login/login_screen.dart';
import 'package:se346/Screens/UserScreen/user_screen.dart';
import 'package:se346/Screens/Welcome/welcome_screen.dart';
import 'package:se346/components/local_notification_service.dart';
import 'package:se346/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
  print(message.ttl);
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = FirebaseAuth.instance.currentUser!.uid;

  bool start = true;

  await FirebaseFirestore.instance
      .collection('users')
      .snapshots().listen((event) {
     if(event.docs.isEmpty) {
       if(start){
         start = false;
         newUserToken(userId, token);
       }
     }
     else{
       if(start){
         start = false;
         List<DocumentSnapshot> list = event.docs.where((element) => element['uid'] == userId).toList();
         if(list.isEmpty){
           newUserToken(userId, token);
         }
         else{
           list.first.reference.update(
            {
            'tokens' : token
            });
         }

       }
     }
  });
}

Future newUserToken(String uid, String token) async {
  FirebaseFirestore.instance.collection('users').add({
    'uid': uid,
    'tokens' : token,
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initalize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> fbApp = Firebase.initializeApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ban ty Game th',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        "loginScreen": (context) => LoginScreen(),
      },
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
                  User? user = snapshot.data as User?;
                  if(user == null) {
                    return WelcomeScreen();   //  login screen
                  }
                  else {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('admin').snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          //saveTokenToDatabase(token)
                          if(snapshot.data!.docs.where((element) => (
                              element['user'] == FirebaseAuth.instance.currentUser!.email
                          )).isEmpty){
                            saveToken();
                            return UserMainScreen();
                          }
                          saveAdminToken();
                          return AdminMainScreen();
                        });
                  }
                  return StreamBuilder(
                    stream: FirebaseAuth.instance.userChanges(),
                    builder: (context, snapshot){
                    },
                  );
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

  Future saveAdminToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToAdmin(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToAdmin);
  }

  Future saveTokenToAdmin(String token) async {
    String? email = FirebaseAuth.instance.currentUser!.email;

    bool start = true;

    FirebaseFirestore.instance.collection('admin').where('user', isEqualTo: email)
    .snapshots().listen((event) {
      if(start){
        start = false;
        event.docs.first.reference.update({
          'token' : token
        });
      }
    });
  }

  Future saveToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }
}
