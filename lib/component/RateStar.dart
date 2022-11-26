import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Ratestar extends StatelessWidget {
  // const Ratestar({super.key});
  int rate;
  Ratestar(this.rate);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: rate,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => Icon(
                  Icons.star_rate,
                  size: 20,
                  color: HexColor('#5D5FEF'),
                ))));
  }
}
