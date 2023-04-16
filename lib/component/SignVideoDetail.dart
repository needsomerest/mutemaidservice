import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mutemaidservice/component/VideoCard.dart';
import 'package:mutemaidservice/component/assetplayer.dart';

class SignVideoDetail extends StatefulWidget {
  String Name;
  //Array TagName;
  String UrlVideo;

  SignVideoDetail(this.Name, this.UrlVideo);

  @override
  State<SignVideoDetail> createState() => _SignVideoDetailState();
}

class _SignVideoDetailState extends State<SignVideoDetail> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: InkWell(
        child: Container(
          height: 80,
          width: 50,
          child: VideoCard(widget.Name),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(widget.UrlVideo)));
        },
      ),
    );
  }
}


/*
    Column(
      children: [
        InkWell(
          child: Container(
            height: 200,
            width: 700,
            child: VideoCard("เก็บตรงนี้"),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoPlayerScreen()));
          },
        ),
        InkWell(
          child: Container(
            height: 200,
            width: double.infinity,
            child: VideoCard("กวาด"),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoPlayerScreen()));
          },
        ),
        InkWell(
          child: Container(
            height: 200,
            width: double.infinity,
            child: VideoCard("เช็ด / ถู"),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoPlayerScreen()));
          },
        ),
      ],
    );
 */

