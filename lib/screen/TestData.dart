import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestData extends StatefulWidget {
  @override
  State<TestData> createState() => _TestDataState();
}

class _TestDataState extends State<TestData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายงานคะแนนสอบ")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(document["score"]),
                      ),
                    ),
                    title: Text(document["fname"] + document["lname"]),
                    subtitle: Text(document["email"]),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
