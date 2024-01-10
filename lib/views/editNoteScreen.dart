// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, file_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homeScreen.dart';

class editNoteScreen extends StatefulWidget {
  const editNoteScreen({super.key});

  @override
  State<editNoteScreen> createState() => _editNoteScreenState();
}

class _editNoteScreenState extends State<editNoteScreen> {
  TextEditingController editNoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: editNoteController
                ..text = "${Get.arguments['note'].toString()}",
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notes")
                      .doc(Get.arguments['docId'].toString())
                      .update(
                    {
                      'note': editNoteController.text.trim(),
                    },
                  ).then((value) => {
                            Get.offAll(() => HomeScreen()),
                            log("Data Updated" as num),
                          });
                },
                child: Text("Edit")),
          ],
        ),
      ),
    );
  }
}
