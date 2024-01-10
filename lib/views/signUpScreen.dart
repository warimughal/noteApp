// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../services/signUpServices.dart';
import 'signInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SignUp Screen"),
        // actions: [
        //   Icon(Icons.more_vert),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Lottie.asset("assets/animation_lke5t2z7.json"),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Username",
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userPhoneNumberController,
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.phone),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "PhoneNumber",
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Email",
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: userPasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Password",
                      // prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  )),
              // SizedBox(
              //   height: 10.0,
              // ),
              ElevatedButton(
                  onPressed: () async {
                    var userName = userNameController.text.trim();
                    var userPhoneNumber = userPhoneNumberController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: userEmail, password: userPassword)
                        .then((value) => {
                              log("User Created"),
                              // FirebaseFirestore.instance
                              //     .collection("users")
                              //     .doc(currentUser!.uid)
                              //     .set({
                              //   'userName': userName,
                              //   'userPhoneNumber': userPhoneNumber,
                              //   'userEmail': userEmail,
                              //   'createdAt': DateTime.now(),
                              //   'userId': currentUser!.uid,
                              // }),
                              // log("Data Added"),
                              signUpUser(
                                userName,
                                userPhoneNumber,
                                userEmail,
                                userPassword,
                              ),
                            });
                  },
                  child: Text("Sign Up")),

              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignInScreen());
                },
                child: Container(
                    child: Card(
                        child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Already have an account SignIn"),
                ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
