import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingName extends StatelessWidget {
  // const SettingName({super.key});
  final IconData icon;
  String title;
  final Color color;
  SettingName(this.icon, this.title, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            shape: CircleBorder(),
            color: HexColor('#5D5FEF'), // Button color
            child: SizedBox(
                width: 45,
                height: 45,
                child: Icon(
                  icon,
                  color: color,
                )),
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
