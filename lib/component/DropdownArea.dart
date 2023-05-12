import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';

typedef OnChangeCallback = void Function(dynamic value);

class DropdownArea extends StatefulWidget {
  final AddressData addressData;
  DropdownArea({Key? key, required this.addressData}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DropdownArea> {
  // Initial Selected Value

  String dropdownvalue = 'ไม่เกิน 40 ตร.';

  // List of items in our dropdown menu
  var items = [
    'ไม่เกิน 40 ตร.',
    'ไม่เกิน 80 ตร.',
    'ไม่เกิน 120 ตร.',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: HexColor("E6E6E6"),
                borderRadius: BorderRadius.circular(30),
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
                      widget.addressData.SizeRoom = dropdownvalue;
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
