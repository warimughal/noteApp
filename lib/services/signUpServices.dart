// FirebaseAuth.instance
//                         .createUserWithEmailAndPassword(
//                             email: userEmail, password: userPassword)
//                         .then((value) => {
//                               log("User Created"),
//                               FirebaseFirestore.instance
//                                   .collection("users")
//                                   .doc(currentUser!.uid)
//                                   .set({
//                                 'userName': userName,
//                                 'userPhoneNumber': userPhoneNumber,
//                                 'userEmail': userEmail,
//                                 'createdAt': DateTime.now(),
//                                 'userId': currentUser!.uid,
//                               }),
// log("Data Added"),

// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/signInScreen.dart';

signUpUser(String userName, String userPhoneNumber, String userEmail,
    String userPassword) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userPhoneNumber': userPhoneNumber,
      'userEmail': userEmail,
      'createdAt': DateTime.now(),
      'userId': userid.uid,
    }).then((value) => {
          FirebaseAuth.instance.signOut(),
          Get.to(() => SignInScreen()),
        });
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}

