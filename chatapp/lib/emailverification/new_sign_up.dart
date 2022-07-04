import 'dart:math';

import 'package:chatapp/components/globalsnackbar.dart';
import 'package:chatapp/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewSignUpPage extends StatefulWidget {
  const NewSignUpPage({Key? key}) : super(key: key);

  @override
  State<NewSignUpPage> createState() => _NewSignUpPageState();
}

class _NewSignUpPageState extends State<NewSignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpassworController = TextEditingController();
  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpassworController.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      // ignore: prefer_const_constructors
      GlobalSnackBar.show(context, 'please enter correct details', Colors.red);

      print(Text("please enter correct details"));
    } else if (password != cpassword) {
      // ignore: prefer_const_constructors
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: const Text('please enter correct password'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print(Text("please enter correct password"));
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
      GlobalSnackBar(message: "login successful", color: Colors.green);
      // print(Text("User Saved "));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Enter Email ID",
                      hintText: "please enter email"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Enter Password",
                      hintText: "please enter Password"),
                ),
                TextFormField(
                  controller: cpassworController,
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "please confirm Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  
                  child: Text("Sign Up"),
                  onPressed: () {
                    createAccount();
                  },
                  color: Colors.teal,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
