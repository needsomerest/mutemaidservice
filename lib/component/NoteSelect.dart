import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';

class NoteSelect extends StatefulWidget {
  final ReservationData reservationData;
  NoteSelect({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  // FormBooking({List<String> items}) : this.items = items ?? [];
  // final List<String> items;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NoteSelect> {
  // Initial Selected Value
  List<DocumentSnapshot> documents = [];

  List<Map<String, dynamic>> SignList = [];

  // List of items in our dropdown menu
  var items = ["เปลี่ยนที่นอนให้สุนัขและแมว", "ปิดประตู", "ขัดชักโครก"];
  String dropdownvalue = "เปลี่ยนที่นอนให้สุนัขและแมว";

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> SignSnapshot = await FirebaseFirestore
        .instance
        .collection('SignLanguageVideo')
        .where('Category', arrayContains: 'User')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> SignDoc
        in SignSnapshot.docs) {
      Map<String, dynamic> docData = SignDoc.data();
      data.add(docData);
    }

    return data;
  }

  @override
  void initState() {
    super.initState();
    _getAddressFromFirebase();
  }

  Future<void> _getAddressFromFirebase() async {
    SignList = await getDataFromFirebase();
    if (mounted) {
      setState(() {});
    }
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    if (SignList.isNotEmpty) {
      items.clear();
      for (int i = 0; i < SignList.length; i++) {
        items.add(SignList[i]['Name']);
      }
    }
    widget.reservationData.Note =
        widget.reservationData.Note == 'Note' ? items[0] : dropdownvalue;
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
                    if (mounted) {
                      setState(() {
                        dropdownvalue = newValue!;
                        widget.reservationData.Note = dropdownvalue.toString();
                      });
                    }
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
