import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoJobAtom extends StatefulWidget {
  // const InfoJobAtom({super.key});
  String img;
  String title;
  InfoJobAtom(this.img, this.title);
  @override
  State<InfoJobAtom> createState() => _InfoJobAtomState();
}

class _InfoJobAtomState extends State<InfoJobAtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  widget.img,
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ));
  }
}
