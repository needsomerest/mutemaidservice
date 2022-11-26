import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatAtom extends StatefulWidget {
  // const ChatAtom({super.key});
  String img;
  String name;
  String lastchat;
  ChatAtom(this.img, this.name, this.lastchat);

  @override
  State<ChatAtom> createState() => _ChatAtomState();
}

class _ChatAtomState extends State<ChatAtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, left: 30),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15, right: 20),
              height: 58,
              width: 58,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  widget.img,
                ),
                radius: 220,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.lastchat,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ));
  }
}
