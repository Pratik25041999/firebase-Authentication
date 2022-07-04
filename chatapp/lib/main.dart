// ignore_for_file: prefer_const_constructors

import 'package:chatapp/auth_page.dart';
import 'package:chatapp/emailverification/new_login_page.dart';
import 'package:chatapp/emailverification/new_phone_verification.dart';
import 'package:chatapp/emailverification/new_sign_up.dart';
import 'package:chatapp/login_page.dart';
import 'package:chatapp/page1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static final String title = "setup firbase";
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          // fontFamily: 'popins'
        ),
        home: (FirebaseAuth.instance.currentUser != null)
            ? New_phone_verification()
            : NewLoginPage(),
      );
}

// class MyApp extends StatelessWidget {
//   static final String title = "setup firbase";
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         navigatorKey: navigatorKey,
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: NewLoginPage(),
//       );
// }

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("some thimg went worng"),
              );
            } else if (snapshot.hasData) {
              return Page1();
            } else {
              return AuthPage();
            }
            //
          }));
}
