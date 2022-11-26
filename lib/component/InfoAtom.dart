import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoAtom extends StatelessWidget {
  // const SettingName({super.key});
  final IconData icon;
  String title;
  String subtitle;
  InfoAtom(this.icon, this.title, this.subtitle);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 45,
                    height: 45,
                    child: Icon(
                      icon,
                      color: HexColor('#1C1B1F'),
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (subtitle != "0") ...[
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ]
          ],
        ));
  }
}
