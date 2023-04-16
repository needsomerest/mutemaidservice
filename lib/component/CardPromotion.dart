import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardPromotion extends StatelessWidget {
  String title;
  String subtitle;
  String img;
  double height;
  double fontsize;
  double margin;
  // CardPromotion(this.img, this.height);
  // CardPromotion(this.title, this.img, this.height, this.fontsize, this.margin);
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
          // height: height,
          // color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FittedBox(
              //   // height: height,
              //   child: Image.network(img, height: height, fit: BoxFit.fitWidth),
              //   fit: BoxFit.fill,
              // ),
              // Ink.image(
              //     height: height,
              //     fit: BoxFit.fitWidth,
              //     image: CachedNetworkImageProvider(img)),
              // Ink.image(
              //   height: height,
              //   image: AssetImage(
              //     "assets/images/ads.jpg",
              //   ),
              //   fit: BoxFit.fitWidth,
              // ),
              // Container(
              //   height: height,
              //   foregroundDecoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: NetworkImage(img),
              //         // NetworkImage(
              //         //     "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/AdsImage%2FAds2.jpg?alt=media&token=938dd1f5-5e98-4601-bcea-d69010334e82"),
              //         fit: BoxFit.fill),
              //   ),
              // ),
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
                  // overflow: TextOverflow.ellipsis,
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
                  // overflow: TextOverflow.ellipsis,
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
