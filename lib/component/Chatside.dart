import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class Chatside extends StatefulWidget {
  // const Chatside({super.key});
  bool side_sender;
  Chatside(this.side_sender);

  @override
  State<Chatside> createState() => _ChatsideState();
}

class _ChatsideState extends State<Chatside> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      // margin: EdgeInsets.only(top: 20),
      // decoration: BoxDecoration(
      //           color: HexColor('#FFFFFF'),
      //           borderRadius: BorderRadius.only(
      //               topRight: Radius.circular(30),
      //               topLeft: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: widget.side_sender == false
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.side_sender == false) ...[
            Container(
              // alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: 15, right: 10, left: 20),
              height: 43,
              width: 43,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/profilemaid.jpg",
                ),
                radius: 220,
              ),
            ),
          ] else ...[
            Container(
              height: 300,
              alignment: Alignment.bottomLeft,
              child: Text(
                '08:05',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#979797')),
                // textAlign: TextAlign.end,
              ),
            ),
          ],
          Container(
            height: 300,
            width: 250,
            padding: EdgeInsets.all(25),
            margin: widget.side_sender == false
                ? EdgeInsets.all(0)
                : EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: widget.side_sender == false
                  ? HexColor('#BDBDBD').withOpacity(0.25)
                  : HexColor('#5D5FEF').withOpacity(0.2),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Flexible(
              child: Text(
                'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (widget.side_sender == false) ...[
            Container(
              height: 300,
              alignment: Alignment.bottomRight,
              child: Text(
                '08:05',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#979797')),
                // textAlign: TextAlign.end,
              ),
            )
          ],
        ],
      ),
    );
  }
}
