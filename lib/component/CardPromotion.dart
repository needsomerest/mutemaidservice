import 'package:flutter/material.dart';

class CardPromotion extends StatelessWidget {
  String title;
  String subtitle;
  String img;
  double height;
  double fontsize;
  double margin;

  CardPromotion(this.title, this.subtitle, this.img, this.height, this.fontsize,
      this.margin);

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.blueGrey,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(margin),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: fontsize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(margin + 1),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: fontsize,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
