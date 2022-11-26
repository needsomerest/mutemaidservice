import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/StarButton.dart';

class Review extends StatelessWidget {
  // const Review({super.key});
  String img;
  String name;
  String star;
  String comment;
  String date;
  Review(this.img, this.name, this.star, this.comment, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 150,
        margin: EdgeInsets.only(left: 30, top: 20, right: 30),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15, right: 20),
                  height: 58,
                  width: 58,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      img,
                    ),
                    radius: 220,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                StarButton(star, 25, 65, 15, 14, false),
              ],
            ),
            Text(
              comment,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(date,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#979797')))
          ],
        ));
  }
}
