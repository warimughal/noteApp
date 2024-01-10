// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unused_catch_clause, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'forgotPasswordScreen.dart';
import 'homeScreen.dart';
import 'signUpScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("SignIn Screen"),
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
                  controller: loginEmailController,
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
                    controller: loginPasswordController,
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
                    var loginEmail = loginEmailController.text.trim();
                    var loginPassword = loginPasswordController.text.trim();

                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginEmail, password: loginPassword))
                          .user;
                      if (firebaseUser != null) {
                        Get.to(() => HomeScreen());
                      } else {
                        print("Check Email and Password");
                      }
                    } on FirebaseAuth catch (e) {
                      print("Error $e");
                    }
                  },
                  child: Text("Sign in")),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ForgotPasswordScreen());
                },
                child: Container(
                    child: Card(
                        child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Forgot Password"),
                ))),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: Container(
                    child: Card(
                        child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Don't have an account Signup"),
                ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
