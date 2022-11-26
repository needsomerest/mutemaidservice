import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'assetplayer.dart';

class VideoCard extends StatelessWidget {
  String title;
  VideoCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor('#5D5FEF')),
          ),
          SizedBox(width: 20),
          Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(color: Colors.white),
                alignment: Alignment.center,
                height: 150,
                child: Image.asset("assets/images/sign.jpg",
                    // height: 200, width: 200,
                    fit: BoxFit.fill),
              ),
              Positioned(
                right: 80,
                bottom: 40,
                child: Icon(
                  Icons.play_circle,
                  size: 70,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
