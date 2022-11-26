import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/PlaceScreen/AddPlaceScreen.dart';

class PlaceAtom extends StatelessWidget {
  // const PlaceAtom({super.key});
  String name;
  String img;
  PlaceAtom(this.name, this.img);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          border: Border.all(width: 2.0, color: HexColor('#5D5FEF')),
          // border: Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                child: Material(
                  shape: CircleBorder(),
                  color: HexColor('#5D5FEF'), // Button color
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addplace(true)));
                },
              )
            ],
          ),
          Image.asset(
            img,
            height: 110,
            width: 100,
          )
        ],
      ),
    );
  }
}
