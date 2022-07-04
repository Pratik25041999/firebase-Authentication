import 'package:chatapp/components/globalsnackbar.dart';
import 'package:chatapp/emailverification/new_login_page.dart';
import 'package:chatapp/page1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class New_phone_verification extends StatefulWidget {
  const New_phone_verification({Key? key}) : super(key: key);

  @override
  State<New_phone_verification> createState() => _New_phone_verificationState();
}

class _New_phone_verificationState extends State<New_phone_verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Verification"),
      ),
      body: Column(
        children: [
          Center(
            child: CupertinoButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => NewLoginPage()));
                },
                child: Text("data")),
          ),
          CupertinoButton(
              child: Text("mobile"),
              onPressed: () {
                Navigator.push(
                    context, CupertinoPageRoute(builder: (context) => Page1()));
              }),
          CupertinoButton(
            child: Text("snackbarrrrrrrrrr"),
            onPressed: () => GlobalSnackBar.show(context, 'Test', Colors.blue),
          )
        ],
      ),
    );
  }
}
