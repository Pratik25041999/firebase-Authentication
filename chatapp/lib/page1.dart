// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:chatapp/verifiyotp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void SendOTP() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    String phone = "+91" + _phonenoController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      VerifyOTP(verificationId: verificationId)));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          log(ex.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("login success ful"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: _phonenoController,
                  decoration: InputDecoration(labelText: "Enter phone number"),
                ),

                CupertinoButton(
                    child: Text("verify"),
                    onPressed: () {
                      SendOTP();
                    }),

                Text(
                  "login success full",
                  style: TextStyle(fontSize: 20),
                ),
                // Text(user.email!),

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      child: Text("Sign out")),
                )
                // ElevatedButton(onPressed: signIn, child: Text("Sign in"))
              ],
            ),
          ),
        ),
      
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }
}
