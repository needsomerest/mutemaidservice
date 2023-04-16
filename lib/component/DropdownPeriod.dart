import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class DropdownPeriod extends StatefulWidget {
  final ReservationData reservationData;
  DropdownPeriod({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  // FormBooking({List<String> items}) : this.items = items ?? [];
  // final List<String> items;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DropdownPeriod> {
  // Initial Selected Value

  String dropdownvalue = '2 ชม. แนะนำ';

  // List of items in our dropdown menu
  var items = [
    '2 ชม. แนะนำ',
    '3 ชม.',
    '4 ชม.',
    '5 ชม.',
    '6 ชม.',
    '7 ชม.',
    '8 ชม.',
  ];
  @override
  Widget build(BuildContext context) {
    dropdownvalue = widget.reservationData.Timeservice == ""
        ? "2 ชม. แนะนำ"
        : widget.reservationData.Timeservice;
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
                      widget.reservationData.Timeservice =
                          dropdownvalue.toString();
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
