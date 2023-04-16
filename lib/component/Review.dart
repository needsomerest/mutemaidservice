import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/StarButton.dart';

class Review extends StatefulWidget {
  String img;
  String name;
  String star;
  String comment;
  String date;
  Review(this.img, this.name, this.star, this.comment, this.date);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 100,
        margin: EdgeInsets.only(left: 10, top: 20, right: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.img),
                radius: 20,
              ),
              Text(
                "  ${widget.name}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              StarButton(widget.star.toString(), 25, 65, 15, 14, false),
            ]),
            Text(
              widget.comment,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(widget.date,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#979797')))
          ],
        ));
  }
}
