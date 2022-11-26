import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DropdownArea extends StatefulWidget {
  const DropdownArea({Key? key}) : super(key: key);

  // FormBooking({List<String> items}) : this.items = items ?? [];
  // final List<String> items;
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
