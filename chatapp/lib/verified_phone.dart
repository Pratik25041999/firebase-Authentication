// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Verified extends StatefulWidget {
  const Verified({Key? key}) : super(key: key);

  @override
  State<Verified> createState() => _VerifiedState();
}

class _VerifiedState extends State<Verified> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  File? profilepic;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void saveUsers() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    _emailController.clear();
    _nameController.clear();
    if (name != "" && email != "" && profilepic != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profilepicture")
          .child(Uuid().v1())
          .putFile(profilepic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadurl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> userdata = {
        "name": name,
        "email": email,
        "profilepic": downloadurl
      };
      FirebaseFirestore.instance.collection("users").add(userdata);
      print("user created");
      const snackdemo = SnackBar(
        content: Text(" details saved"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      print("please enter correct details");
      const snackdemo = SnackBar(
        content: Text("please enter correct details"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }
    setState(() {
      profilepic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Verify Verified"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () async {
                  XFile? selectedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (selectedImage != null) {
                    File covertedFile = File(selectedImage.path);
                    setState(() {
                      profilepic = covertedFile;
                    });
                    print("immage selected");
                  } else {
                    print("no image");
                  }
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      (profilepic != null) ? FileImage(profilepic!) : null,
                  backgroundColor: Colors.amber,
                ),
              ),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    label: Text("Enter Name"), hintText: "Name"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    label: Text("Enter mail id"), hintText: "email"),
              ),

              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: Text("save"),
                  onPressed: () {
                    saveUsers();

                    //          Navigator.push(
                    // context, CupertinoPageRoute(builder: (context) => Home()));
                  }),

              //          ElevatedButton(
              //   style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(Colors.green)),
              //   onPressed: () {
              //     const snackdemo = SnackBar(
              //       content: Text('Hii this is GFG\'s SnackBar'),
              //       backgroundColor: Colors.green,
              //       elevation: 10,
              //       behavior: SnackBarBehavior.floating,
              //       margin: EdgeInsets.all(5),
              //     );
              //     ScaffoldMessenger.of(context).showSnackBar(snackdemo);

              //     // 'showSnackBar' is deprecated and shouldn't be used.
              //     //Use ScaffoldMessenger.showSnackBar.
              //     // Scaffold.of(context).showSnackBar(snackdemo);
              //   },
              //   child: const Text('Click Here'),
              // ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userMap =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userMap["profilepic"]),
                                ),
                                title: Text(userMap['name']),
                                subtitle: Text(userMap['email']),
                                trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();

                                    // print(snapshot.data!.docs[index]
                                    //     .toString());
                                  },
                                  icon: Icon(Icons.delete),
                                ));

                            //  Column(
                            //   children: [Text(userMap['name'].toString())],
                            // );
                          },
                        ),
                      );
                    } else {
                      return Text("no data");
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              // ElevatedButton(onPressed: signIn, child: Text("Sign in"))
            ],
          ),
        ),
      ),
    );
  }

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim());
  // }
}
