import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mutemaidservice/component/CardPromotion.dart';

class PromotionCardSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Ads").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((AdsDocument) {
                  return Container(
                    height: 200,
                    width: 200,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Flexible(
                        child: CardPromotion(
                          AdsDocument["AdsHeader"],
                          AdsDocument["AdsDetails"],
                          AdsDocument["AdsPicture"],
                          100,
                          12,
                          5,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }));
}
