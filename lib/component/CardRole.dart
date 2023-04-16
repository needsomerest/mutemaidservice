// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../component/CardPromotion.dart';

class CardRole extends StatefulWidget {
  // const CardRole({super.key});
  String img;
  String title;
  CardRole(this.img, this.title);

  @override
  State<CardRole> createState() => _CardRoleState();
}

class _CardRoleState extends State<CardRole> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.blueGrey,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
            height: 200,
            width: 300,
            padding: EdgeInsets.all(20),
            color: HexColor('5D5FEF').withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  // "assets/images/viber.png",
                  widget.img,
                  // color: Colors.white,
                  color: HexColor('5D5FEF'),
                  width: 150,
                  height: 120,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.title,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        // color: Colors.white,
                        color: HexColor('5D5FEF'),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )));
  }
}
