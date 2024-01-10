// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison, non_constant_identifier_names, body_might_complete_normally_nullable, avoid_types_as_parameter_names, unused_local_variable, prefer_const_literals_to_create_immutables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:note_app/views/createNoteScreen.dart';
import 'package:note_app/views/editNoteScreen.dart';
import 'package:note_app/views/signInScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => SignInScreen());
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .where("userId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No Data Found"));
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var note = snapshot.data!.docs[index]['note'];
                    var noteId = snapshot.data!.docs[index]['userId'];
                    var docId = snapshot.data!.docs[index].id;
                    Timestamp date = snapshot.data!.docs[index]['CreatedAt'];
                    var finalDate = DateTime.parse(date.toDate().toString());
                    return Card(
                      child: ListTile(
                        title: Text(note),
                        // subtitle: Text(noteId),
                        subtitle: Text(GetTimeAgo.parse(finalDate)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => editNoteScreen(),
                                    arguments: {
                                      'note': note,
                                      'docId': docId,
                                    },
                                  );
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection("notes")
                                      .doc(docId)
                                      .delete();
                                },
                                child: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => createNoteScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
