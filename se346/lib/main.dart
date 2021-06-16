import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

bool checkInfoUser(User user){
  if(user.photoURL == defaultAvatar || user.photoURL == "" || user.photoURL == null){
    user.updatePhotoURL("https://firebasestorage.googleapis.com/v0/b/e-commerce-app-f6fa8.appspot.com/o/89421820_p0.jpg?alt=media&token=bcad557c-b056-42bc-bf1b-d655a9744048");
    return false;
  }
  if(user.displayName == null){
    user.updateDisplayName("Username");
    return false;
  }
  return true;
}

final FirebaseAuth auth = FirebaseAuth.instance;
final String defaultAvatar = "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-f6fa8.appspot.com/o/avatar.png?alt=media&token=a8d5be3c-a233-466c-aae2-785ac05e741a";
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
                    return WelcomeScreen();   //  login screen
                  }
                  else {
                    return StreamBuilder(
                      stream: adminList.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasData){
                          if(!checkInfoUser(auth.currentUser!))
                            auth.currentUser!.reload();
                          List<Text> listTxtAdmin = snapshot.data!.docs.map((e) => Text(e['user'])).toList();
                          bool isAdmin = false;
                          for(int i = 0; i < listTxtAdmin.length; i++){
                            if(listTxtAdmin[i].data == auth.currentUser!.email){
                              //print(auth.currentUser!.displayName);
                              isAdmin = true;
                            }
                          }
                          if(isAdmin)
                            return OverViewScreen();  //admin screen
                          else
                            return Scaffold(      //customer screen
                              body: Center(
                                child: MaterialButton(
                                  child: Text("Log out"),
                                  onPressed: (){
                                    auth.signOut();
                                  },
                                ),
                              ),
                            );
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
