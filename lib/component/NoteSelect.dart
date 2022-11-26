import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NoteSelect extends StatefulWidget {
  const NoteSelect({Key? key}) : super(key: key);

  // FormBooking({List<String> items}) : this.items = items ?? [];
  // final List<String> items;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NoteSelect> {
  // Initial Selected Value

  String dropdownvalue = 'เปลี่ยนผ้าคลุมเตียงและปลอกหมอน';

  // List of items in our dropdown menu
  var items = [
    'เปลี่ยนผ้าคลุมเตียงและปลอกหมอน',
    'เก็บหนังสือพิมพ์ไว้ใช้ประโยชน์',
    'เปลี่ยนที่นอนให้สัตว์เลี้ยง',
    'ทำความสะอาดห้องนั่งเล่น',
  ];
  @override
  Widget build(BuildContext context) {
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
                  color: HexColor('5D5FEF').withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: HexColor('#5D5FEF'))),
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
                  dropdownColor: HexColor('#E6E6E6'),
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
