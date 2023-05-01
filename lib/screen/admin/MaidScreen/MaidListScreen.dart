import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/admin/MaidScreen/DeleteSuccess.dart';
import 'package:mutemaidservice/screen/admin/MaidScreen/EditMaidScreen.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/DeleteAccountSuccess.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../HomeScreen/HomeScreen.dart';

class MaidListScreen extends StatefulWidget {
  const MaidListScreen({super.key});

  @override
  State<MaidListScreen> createState() => _MaidListScreenState();
}

late String currentid;

class _MaidListScreenState extends State<MaidListScreen> {
  final TextEditingController _controllersSearch = TextEditingController();

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Housekeeper').get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> docData = doc.data();
      docData['id'] = doc.id;
      data.add(docData);
    });

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> usersFiltered = [];
  String name = "";
  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
    usersFiltered = dataList;
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {}); // rebuild the widget with the fetched data
  }

  @override
  Widget build(BuildContext context) {
    DataTable table = DataTable(
      showCheckboxColumn: false,
      headingRowColor: MaterialStateColor.resolveWith((states) {
        // Use a color for the heading row based on the current theme
        return HexColor('#C1C1F0');
      }),
      headingTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Kanit',
          color: Colors.black),
      border:
          TableBorder.all(borderRadius: BorderRadius.all(Radius.circular(0))),
      columns: [
        // DataColumn(label: Text('รหัสพนักงาน')),
        DataColumn(label: Text('ชื่อ-นามสกุล')),
        // DataColumn(label: Text('นามสกุล')),
        DataColumn(label: Text('แก้ไข')),
        DataColumn(label: Text('ลบ')),
      ],
      rows: name.isEmpty
          ? dataList
              .map((data) => DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        // Use a color for the heading row based on the current theme
                        return HexColor('#EFEFFE');
                      }),
                      // onSelectChanged: (isSelected) {
                      //   if (isSelected == true) {
                      //     setState(() {
                      //       currentid = data['id'];
                      //     });
                      //     _onAlertButtonPressed(context);
                      //   }
                      // },
                      cells: [
                        // DataCell(Text(data['id'].substring(0, 5))),
                        DataCell(
                            Text('${data['FirstName']} ${data['LastName']}')),
                        // DataCell(Text(data['LastName'])),
                        DataCell(
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // EditNameForm("กนกพร", "สุขใจ"))
                                        EditMaidScreen(data['id'])),
                              );
                            },
                            child: Icon(
                              Icons.drive_file_rename_outline,
                              color: HexColor('#5D5FEF'),
                            ),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentid = data['id'];
                              });
                              _onAlertButtonPressed(context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),

                        // DataCell(
                        //   Icon(
                        //     Icons.delete,
                        //   ),
                        // ),
                      ]))
              .toList()
          : List.generate(
              usersFiltered.length,
              (index) => DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        // Use a color for the heading row based on the current theme
                        return HexColor('#EFEFFE');
                      }),
                      // onSelectChanged: (isSelected) {
                      //   if (isSelected == true) {
                      //     setState(() {
                      //       currentid = data['id'];
                      //     });
                      //     _onAlertButtonPressed(context);
                      //   }
                      // },
                      cells: [
                        // DataCell(Text(data['id'].substring(0, 5))),
                        DataCell(Text(
                            '${usersFiltered[index]['FirstName']} ${usersFiltered[index]['LastName']}')),
                        // DataCell(Text(data['LastName'])),
                        DataCell(
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // EditNameForm("กนกพร", "สุขใจ"))
                                        EditMaidScreen(
                                            usersFiltered[index]['id'])),
                              );
                            },
                            child: Icon(
                              Icons.drive_file_rename_outline,
                              color: HexColor('#5D5FEF'),
                            ),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentid = usersFiltered[index]['id'];
                              });
                              _onAlertButtonPressed(context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),

                        // DataCell(
                        //   Icon(
                        //     Icons.delete,
                        //   ),
                        // ),
                      ])).toList(),
    );
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
          size: 30,
        ),
        title: Text('รายชื่อแม่บ้าน',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight
                    .bold)), //"${currentLocation.latitude} ${currentLocation.longitude}"
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _controllersSearch,
                cursorColor: HexColor("#5D5FEF"),
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(14),
                    hintText: 'ค้นหาด้วยชื่อหรือนามสกุล',
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                        //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                      ),
                    ),
                    filled: true,
                    fillColor: HexColor("#DFDFFC"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      borderSide: BorderSide(
                        color: HexColor("#5D5FEF"),

                        //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: HexColor("#5D5FEF"),
                    )),
                onChanged: (val) {
                  setState(() {
                    name = val;
                    // if (name.isNotEmpty) {
                    usersFiltered = dataList
                        .where((data) =>
                            data['FirstName']
                                .toString()
                                .toLowerCase()
                                .startsWith(name.toLowerCase()) ||
                            data['LastName']
                                .toString()
                                .toLowerCase()
                                .startsWith(name.toLowerCase()))
                        .toList();
                    // }
                    // else {
                    //   usersFiltered = dataList;
                    // }
                  });
                },
              ),
              SizedBox(height: 30),
              Container(
                width: 500,
                height: 500,
                child: ListView(
                  children: [
                    if (dataList.isEmpty)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      table,
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        ),
      ),
    );
  }
}

_onAlertButtonPressed(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "ลบบัญชีแม่บ้าน",
    desc: "หากทำการลบบัญชีแม่บ้าน ระบบจะทำการลบข้อมูลทุกอย่าง",
    style: AlertStyle(
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "ยืนยัน",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          deleteData();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeleteSuccess()));
        },
        color: HexColor('#5D5FEF'),
        // borderRadius: BorderRadius.all(Radius.circular(2.0),
      ),
      DialogButton(
        child: Text(
          "ยกเลิก",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: HexColor('#BDBDBD').withOpacity(0.2),
      )
    ],
  ).show();
}

Future deleteData() async {
  try {
    await FirebaseFirestore.instance
        .collection("Housekeeper")
        .doc(currentid)
        .delete();

    print("sucess");
  } catch (e) {
    return print(e);
  }
}
