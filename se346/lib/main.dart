
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:se346/Screens/AdminScreen/admin_screen.dart';
import 'package:se346/Screens/Login/login_screen.dart';
import 'package:se346/Screens/UserScreen/MainScreen/main_screen.dart';
import 'package:se346/Screens/UserScreen/user_screen.dart';
import 'package:se346/Screens/Welcome/welcome_screen.dart';
import 'package:se346/constants.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Screens/AdminScreen/AdminMainScreen/overview_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> fbApp = Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //FlutterLocalNotificationsPlungin flutterLocalNotificationsPlungin;

  @override
  void initState() {
    NotificationPermission();
    super.initState();
  }



  void getToken() async {
    print(await messaging.getToken());
  }

  @override
  Widget build(BuildContext context) {
    getToken();
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
                            return UserMainScreen();
                          }

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

  void initMessaging() {
    var androidinit = AndroidInitializationSettings('ic_launcher');

    var iosInit = IOSInitializationSettings();

    var initSetting = InitializationSettings(android: androidinit, iOS: iosInit);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification();
    });
  }

  void showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(0, 'title', 'body', generalNotificationDetails, payload: 'notificationDetails');
  }

  void NotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
