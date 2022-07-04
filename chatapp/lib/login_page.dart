// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickSignUp;
  LoginPage({Key? key,required this.onClickSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "login Page",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("login Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                      hintText: "enter emailid",
                      label: Text("email")),
                  controller: _emailController,
                ),
                Container(
                  height: 16,
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                      hintText: "enter password",
                      label: Text("password")),
                ),
                ElevatedButton(onPressed: signIn, child: Text("Sign in")),
                RichText(
                    text: TextSpan(text: "No account" ,
                    style: TextStyle(color: Colors.black)
                    , children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = widget.onClickSignUp,
                      style: TextStyle(color: Colors.blue),
                      text: " Sign up")
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
