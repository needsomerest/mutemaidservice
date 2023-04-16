import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mutemaidservice/component/SignVideoDetail.dart';

class SignVideoList extends StatefulWidget {
  String category;
  bool height;
  SignVideoList(this.category, this.height);

  @override
  State<SignVideoList> createState() => _SignVideoListState();
}

class _SignVideoListState extends State<SignVideoList> {
  var excludedTags = [
    'User'
  ]; /* [
    "ห้องครัว",
    "ห้องน้ำ",
    "ห้องพระ",
    "ห้องทำงาน",
    "ห้องนั่งเล่น",
    "นอกอาคาร",
    "ชั้นอาคาร",
    "ซักรีด",
    "ทำความสะอาด",
    "สัตว์เลี้ยง",
    "เฟอร์นิเจอร์",
    "อื่นๆ",
  ];*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 380,
        height: widget.height == true ? 300 : 450,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("SignLanguageVideo")
                .where('Category', arrayContains: widget.category)
                /*.where('Tag', arrayContains: query)*/
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((SignDocument) {
                    return SignVideoDetail(
                        SignDocument["Name"], SignDocument["Url"]);
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}

/**
 * 
 * StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SignLanguageVideo")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((SignDocument) {
                return SignVideoDetail(SignDocument["Name"],
                    SignDocument["Tag"], SignDocument["Url"]);
              }).toList(),
            );
          }
        });
 */