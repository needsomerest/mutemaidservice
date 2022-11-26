import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class StarButton extends StatelessWidget {
  // const StarButton({super.key});
  String title;
  double height;
  double width;
  double size;
  double fontsize;
  bool choose;
  StarButton(this.title, this.height, this.width, this.size, this.fontsize,
      this.choose);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: choose == true ? HexColor('#5D5FEF') : HexColor('#FFFFFF'),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: HexColor('#5D5FEF'), width: 2),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.star_rate,
          size: size,
          color: choose == true ? HexColor('#FFFFFF') : HexColor('#5D5FEF'),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: TextStyle(
              color: choose == true ? HexColor('#FFFFFF') : HexColor('#5D5FEF'),
              fontSize: fontsize,
              fontWeight: FontWeight.bold),
        ),
      ]

          // trailing: Icon(Icons.more_vert),
          ),
    );
  }
}
