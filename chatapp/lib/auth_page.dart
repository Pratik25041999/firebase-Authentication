import 'package:chatapp/login_page.dart';
import 'package:chatapp/page1.dart';
import 'package:chatapp/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool islogin = true;

  @override
  Widget build(BuildContext context) => islogin
      ? LoginPage(
          onClickSignUp: toggle,
        )
      : SignupPage(
          onClickSignUp: toggle,
        );

  void toggle() => setState(() => islogin = !islogin);
}
