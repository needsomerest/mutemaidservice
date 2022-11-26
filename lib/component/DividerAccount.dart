import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DividerAccount extends StatelessWidget {
  String title;
  double height;

  DividerAccount(this.title, this.height);
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: HexColor("DDDDDD"),
              height: height,
            )),
      ),
      Text(
        title,
        style: TextStyle(color: HexColor("BDBDBD")),
      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: HexColor("DDDDDD"),
              height: height,
            )),
      ),
    ]);
  }
}
