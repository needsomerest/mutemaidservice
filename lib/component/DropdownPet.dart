import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/BookingScreen/BookingScreen.dart';

class DropdownPet extends StatefulWidget {
  final ReservationData reservationData;
  DropdownPet({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  // FormBooking({List<String> items}) : this.items = items ?? [];
  // final List<String> items;
  @override
  _MyPetPageState createState() => _MyPetPageState();
}

class _MyPetPageState extends State<DropdownPet> {
  // Initial Selected Value

  String dropdownvalue = 'ไม่มี';

  // List of items in our dropdown menu
  var items = [
    'ไม่มี',
    'สุนัข',
    'แมว',
    'อื่นๆ',
  ];
  @override
  Widget build(BuildContext context) {
    dropdownvalue =
        widget.reservationData.Pet == "" ? 'ไม่มี' : widget.reservationData.Pet;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Geeksforgeeks"),
      // ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: HexColor("E6E6E6"),
                borderRadius: BorderRadius.circular(50),
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //       color:
                //           Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                //       blurRadius: 5) //blur radius of shadow
                // ]
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // isExpanded: true,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      widget.reservationData.Pet = dropdownvalue.toString();
                    });
                  },
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  // borderRadius: BorderRadius.circular(10),
                  dropdownColor: HexColor("E6E6E6"),
                  iconEnabledColor: HexColor("1C1B1F"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
