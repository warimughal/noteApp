// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/signInScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),

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
                  controller: forgotPasswordController,
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

              ElevatedButton(
                  onPressed: () async {
                    var forgotEmail = forgotPasswordController.text.trim();

                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: forgotEmail)
                          .then((value) => {
                                print("Email Sent"),
                                Get.off(() => SignInScreen()),
                              });
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                    }
                  },
                  child: Text("Forgot Password")),
            ],
          ),
        ),
      ),
    );
  }
}
