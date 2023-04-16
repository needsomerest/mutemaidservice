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
        padding: EdgeInsets.only(top: 10, left: 30, bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 58,
              width: 58,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.img,
                ),
                radius: 220,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    widget.lastchat,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
