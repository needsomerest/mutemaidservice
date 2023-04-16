import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mutemaidservice/component/GetUserReview.dart';
import 'package:mutemaidservice/component/Review.dart';

class ReviewList extends StatefulWidget {
  String housekeeperid;
  String filter;
  ReviewList(this.housekeeperid, this.filter);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            if (widget.filter == '5' ||
                widget.filter == '4' ||
                widget.filter == '3' ||
                widget.filter == '2' ||
                widget.filter == '1') ...[
              Container(
                alignment: Alignment.topCenter,
                width: 380,
                height: 300,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Housekeeper")
                        .doc(widget.housekeeperid)
                        .collection('Review')
                        .where('Score', isEqualTo: int.parse(widget.filter))
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs.map((ReviewDocument) {
                            return GetUserReview(
                                UserID: ReviewDocument['UserID'],
                                Score: ReviewDocument['Score'].toString(),
                                ReviewDetail: ReviewDocument['ReviewDetail'],
                                DateTimeReview:
                                    ReviewDocument['DateTimeReview']);
                          }).toList(),
                        );
                      }
                    }),
              ),
            ] else ...[
              Container(
                alignment: Alignment.topCenter,
                width: 380,
                height: 300,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Housekeeper")
                        .doc(widget.housekeeperid)
                        .collection('Review')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs.map((ReviewDocument) {
                            return GetUserReview(
                                UserID: ReviewDocument['UserID'],
                                Score: ReviewDocument['Score'].toString(),
                                ReviewDetail: ReviewDocument['ReviewDetail'],
                                DateTimeReview:
                                    ReviewDocument['DateTimeReview']);
                          }).toList(),
                        );
                      }
                    }),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
