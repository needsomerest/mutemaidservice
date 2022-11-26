import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FrequencyText extends StatelessWidget {
  String title;

  FrequencyText(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: HexColor("#E6E6E6"), borderRadius: BorderRadius.circular(20)),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: HexColor('#06161C')),
      ),
    );
  }
}
