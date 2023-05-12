import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/screen/PlaceScreen/map.dart';

class Textinput extends StatelessWidget {
  String title;
  String hint;
  final AddressData addressData;

  // const LocationForm({super.key});
  Textinput(
      {Key? key,
      required this.title,
      required this.hint,
      required this.addressData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // if(add==false)...[]
        SizedBox(
          width: 396,
          height: 32,
          child: GestureDetector(
            child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: HexColor('#5D5FEF').withOpacity(0.2),
                    border: Border.all(width: 3, color: HexColor('#5D5FEF')),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/locationpoint.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      hint,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
                // : Text(
                //     address == "" ? "" : address,
                //     style: TextStyle(
                //         fontSize: 14,
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold),
                //   ),
                ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapsPage()));
              // NotificationScreen()));
            },
          ),
        )
      ],
    );
  }
}
