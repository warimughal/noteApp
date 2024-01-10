// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, avoid_print, non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class createNoteScreen extends StatefulWidget {
  const createNoteScreen({super.key});

  @override
  State<createNoteScreen> createState() => _createNoteScreenState();
}

class _createNoteScreenState extends State<createNoteScreen> {
  TextEditingController createNoteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: createNoteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Note"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var note = createNoteController.text.trim();

                if (note != "") {
                  try {
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc()
                        .set({
                      'CreatedAt': DateTime.now(),
                      'note': note,
                      'userId': userId?.uid,
                    });
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                } else {
                  print("Error");
                }
              },
              child: Text("Add Note"),
            )
          ],
        ),
      ),
    );
  }
}
