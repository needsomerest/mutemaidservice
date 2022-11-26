import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mutemaidservice/component/CardPromotion.dart';

class PromotionCardSlide extends StatelessWidget {
  List<String> img = [
    "assets/images/ads.jpg",
    "assets/images/omo.jpg",
    // "assets/images/pic3.jpg",
    // "assets/images/pic4.jpg",
    // "assets/images/pic5.jpg"
  ];
  List<String> title = [
    "เปา วินวอช สูตรใหม่! ซื้อ 1 แถม 1",
    "OMO PLUS! ลด 5 บาททุกถุง",
    // "ส่วนลด 150 บาท สำหรับบริการทำความสะอาด",
    // "ส่วนลด 50 บาท สำหรับบริการทำความสะอาด",
    // "ส่วนลด 250 บาท สำหรับบริการทำความสะอาด"
  ];
  List<String> subtitle = [
    "ใช้โปรโมชั่นนี้ได้ที่ร้าน A ทุกสาขา",
    "ใช้โปรโมชั่นนี้ได้ที่ร้าน B ทุกสาขา",
    // "ส่วนลด 150 บาท สำหรับบริการทำความสะอาด",
    // "ส่วนลด 50 บาท สำหรับบริการทำความสะอาด",
    // "ส่วนลด 250 บาท สำหรับบริการทำความสะอาด"
  ];
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
                      child: CardPromotion(
                        AdsDocument["AdsHeader"],
                        AdsDocument["AdsDetails"],
                        AdsDocument["AdsPicture"],
                        100,
                        12,
                        5,
                      ),
                    ),
                  );
                }).toList(),
              );
            }

            /* Container(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 220,
              child: ListView(
                
                 itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: CardPromotion(
                            title[index],
                            subtitle[index],
                            img[index],
                            100,
                            12,
                            5,
                          ),
                        ),
                      ))),
            )
          ]),
        ),
      )*/
          }));
}
