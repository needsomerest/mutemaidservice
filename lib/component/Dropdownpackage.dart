import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/BookingScreen/BookingScreen.dart';

class DropdownPackage extends StatefulWidget {
  final ReservationData reservationData;
  /*
  final Housekeeper housekeeper;*/
  DropdownPackage({
    Key? key,
    required this.reservationData,
    /*required this.addressData,
      required this.housekeeper*/
  }) : super(key: key);

  // FormBooking({List<String> items}) : this.items = items ?? [];
  // final List<String> items;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DropdownPackage> {
  // Initial Selected Value

  String dropdownvalue = 'ครั้งเดียว';

  // List of items in our dropdown menu
  var items = [
    'ครั้งเดียว',
    'รายเดือน',
    'รายสัปดาห์',
    'รายวัน',
  ];
  @override
  Widget build(BuildContext context) {
    dropdownvalue = widget.reservationData.Package == ""
        ? 'ครั้งเดียว'
        : widget.reservationData.Package;

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
                    });
                    widget.reservationData.Package = dropdownvalue.toString();
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
