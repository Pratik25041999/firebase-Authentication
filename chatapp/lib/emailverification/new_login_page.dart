import 'package:chatapp/emailverification/new_phone_verification.dart';
import 'package:chatapp/emailverification/new_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({Key? key}) : super(key: key);

  @override
  State<NewLoginPage> createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpassworController = TextEditingController();

  void loginFuction() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == null || password == null) {
    } else {
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => New_phone_verification()));
        }
      } on FirebaseAuthException catch (ex) {
        print("errorr");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" Login Page"),
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
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Text("Log In"),
                  onPressed: () {
                    loginFuction();
                  },
                  color: Colors.teal,
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  child: Text("Create New account"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NewSignUpPage()));
                  },
                  // color: Color.fromARGB(255, 0, 255, 21),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => NewSignUpPage()));
                //     },
                //     child: Text("data"))
              ],
            ),
          )
        ],
      )),
    );
  }
}
