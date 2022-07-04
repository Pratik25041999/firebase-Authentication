// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onClickSignUp;
  SignupPage({Key? key, required this.onClickSignUp}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
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
          title: Text("Signup Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        hintText: "enter emailid",
                        label: Text("email")),
                    controller: _emailController,
                  ),
                  Container(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (vaule) => vaule != null && vaule.length < 6
                        ? 'Enter minimum 6 digits'
                        : null,
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        hintText: "enter password",
                        label: Text("password")),
                  ),
                  ElevatedButton(onPressed: signIn, child: Text("Sign in")),
                  RichText(
                      text: TextSpan(
                          text: "No account",
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickSignUp,
                            style: TextStyle(color: Colors.blue),
                            text: " Sign up")
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
final isValid = _formKey.currentState!.validate(); 
if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
