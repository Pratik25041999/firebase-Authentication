// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:path/path.dart' as Path;
import 'package:chatapp/verified_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;

  const VerifyOTP({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else {
      return null.toString();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void verifyOTP() async {
    String otp = _otpController.text.trim();
    _otpController.clear();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        print("objeeeeeeeeect");
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Verified()));
      } else {
        print("help");
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
      print("objec1t");
      //  showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => Center(
      //         child: CircularProgressIndicator(),
      //       ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(labelText: "Enter phone otp"),
              ),

              CupertinoButton(
                  child: Text("verify"),
                  onPressed: () {
                    verifyOTP();
                  }),

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

// String validateMobile(String value) {
//   String patttern = r'(^[0-9]*$)';
//   RegExp regExp = new RegExp(patttern);
//   if (value.length == 0) {
//     return "Mobile is Required";
//   } else if (value.length != 10) {
//     return "Mobile number must 10 digits";
//   } else if (!regExp.hasMatch(value)) {
//     return "Mobile Number must be digits";
//   }
//   return null.toString();
// }
