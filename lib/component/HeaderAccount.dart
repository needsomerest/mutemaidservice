import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HeaderAccount extends StatelessWidget {
  String title;
  double fontsize;
  String titlecolor;
  HeaderAccount(this.title, this.fontsize, this.titlecolor);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      title,
      style: TextStyle(
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
          color: HexColor(titlecolor),
          fontFamily: 'Kanit'),
    ));
  }
}
