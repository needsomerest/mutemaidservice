import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/PlaceScreen/AddPlaceScreen.dart';

class PlaceAtom extends StatelessWidget {
  // const PlaceAtom({super.key});
  String name;
  String img;
  bool select;
  PlaceAtom(this.name, this.img, this.select);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          border: select == true
              ? Border.all(width: 2.0, color: HexColor('#5D5FEF'))
              : Border.all(width: 2.0, color: HexColor('#FFFFFF')),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Addplace(false, true, "")));
                },
              )
            ],
          ),
          Image.network(
            img,
            height: 70,
            width: 90,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
