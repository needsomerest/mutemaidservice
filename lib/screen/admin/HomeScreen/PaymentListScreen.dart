import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/HomeScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/PaymentDetailScreen.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  final TextEditingController _controllersSearch = TextEditingController();

  // Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
  //   List<Map<String, dynamic>> data = [];

  //   QuerySnapshot<Map<String, dynamic>> reservationSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('User')
  //           .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
  //           .collection('Reservation')
  //           .get();

  //   print('Number of Reservation documents: ${reservationSnapshot.size}');

  //   for (QueryDocumentSnapshot<Map<String, dynamic>> reservationDoc
  //       in reservationSnapshot.docs) {
  //     String reservationId = reservationDoc.id;
  //     QuerySnapshot<Map<String, dynamic>> paymentSnapshot = await reservationDoc
  //         .reference
  //         .collection('Payment')
  //         .where('PaymentStatus')
  //         .get();

  //     print(
  //         'Number of Payment documents with PaymentStatus=true in Reservation document $reservationId: ${paymentSnapshot.size}');

  //     for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
  //         in paymentSnapshot.docs) {
  //       Map<String, dynamic> docData = paymentDoc.data();
  //       docData['ReservationId'] = reservationId;
  //       data.add(docData);
  //     }
  //   }

  //   return data;
  // }
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();
    print('Number of User documents: ${UserSnapshot.size}');

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(UserDoc.id)
              .collection('Reservation')
              .get();

      print('Number of Reservation documents: ${reservationSnapshot.size}');

      for (QueryDocumentSnapshot<Map<String, dynamic>> reservationDoc
          in reservationSnapshot.docs) {
        String reservationId = reservationDoc.id;
        QuerySnapshot<Map<String, dynamic>> paymentSnapshot =
            await reservationDoc.reference
                .collection('Payment')
                .where('PaymentStatus')
                .get();

        print(
            'Number of Payment documents with PaymentStatus=true in Reservation document $reservationId: ${paymentSnapshot.size}');

        for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
            in paymentSnapshot.docs) {
          Map<String, dynamic> docData = paymentDoc.data();
          docData['ReservationId'] = reservationId;
          data.add(docData);
        }
      }
    }

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> usersFiltered = [];

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
    usersFiltered = dataList;
    // usersFiltered.addAll(dataList);
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {});
    // print(dataList);
  }

  String name = "";
  bool _ascending = true;
  @override
  Widget build(BuildContext context) {
    void _sortData(int columnIndex, bool ascending) {
      setState(() {
        // print(_sortAscending);
        if (columnIndex == 1) {
          // _ascending = !_ascending;
          if (ascending) {
            // Sort the data by PaymentStatus in ascending order
            usersFiltered.sort(
                (a, b) => a['PaymentStatus'].compareTo(b['PaymentStatus']));
            dataList.sort(
                (a, b) => a['PaymentStatus'].compareTo(b['PaymentStatus']));
          } else {
            // Sort the data by PaymentStatus in descending order
            usersFiltered.sort(
                (a, b) => b['PaymentStatus'].compareTo(a['PaymentStatus']));
            dataList.sort(
                (a, b) => b['PaymentStatus'].compareTo(a['PaymentStatus']));
          }
        }
        _ascending = !_ascending;
      });
    }

    DataTable table = DataTable(
      showCheckboxColumn: false,
      headingRowColor: MaterialStateColor.resolveWith((states) {
        return HexColor('#C1C1F0');
      }),
      headingTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Kanit',
          color: Colors.black),
      border:
          TableBorder.all(borderRadius: BorderRadius.all(Radius.circular(0))),
      sortColumnIndex: 1,
      sortAscending: _ascending,
      columns: [
        DataColumn(
          label: Text('หมายเลขการจอง'),
        ),
        DataColumn(
          label: Text('สถานะ'),
          onSort: (columnIndex, ascending) {
            print(_ascending);
            _sortData(columnIndex, _ascending);
            // print(_ascending);
            // if (check == true) {
            //   _sortData(columnIndex, true);
            //   setState(() {
            //     check = false;
            //   });
            // } else {
            //   _sortData(columnIndex, false);
            //   setState(() {
            //     check = true;
            //   });
            // }
          },
        ),
      ],
      rows: usersFiltered.isNotEmpty
          ? List.generate(
              usersFiltered.length,
              (index) => DataRow(
                color: MaterialStateColor.resolveWith((states) {
                  return HexColor('#EFEFFE');
                }),
                onSelectChanged: (isSelected) {
                  if (isSelected == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailScreen(
                            usersFiltered[index]['ReservationId']),
                      ),
                    );
                  }
                },
                cells: [
                  DataCell(Text(usersFiltered[index]['ReservationId'])),
                  DataCell(Text(usersFiltered[index]['PaymentStatus'])),
                ],
              ),
            )
          : dataList
              .map((data) => DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      return HexColor('#EFEFFE');
                    }),
                    onSelectChanged: (isSelected) {
                      if (isSelected == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentDetailScreen(data['ReservationId'])),
                        );
                      }
                    },
                    cells: [
                      DataCell(Text(data['ReservationId'])),
                      DataCell(Text(data['PaymentStatus'])),
                    ],
                  ))
              .toList(),
    );
    // DataTable table = DataTable(
    //   showCheckboxColumn: false,
    //   headingRowColor: MaterialStateColor.resolveWith((states) {
    //     // Use a color for the heading row based on the current theme
    //     return HexColor('#C1C1F0');
    //   }),
    //   headingTextStyle: TextStyle(
    //       fontSize: 16,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'Kanit',
    //       color: Colors.black),
    //   border:
    //       TableBorder.all(borderRadius: BorderRadius.all(Radius.circular(0))),
    //   columns: [
    //     DataColumn(label: Text('หมายเลขการจอง')),
    //     DataColumn(label: Text('สถานะ')),
    //   ],
    //   rows: name.isNotEmpty
    //       ? List.generate(
    //           usersFiltered.length,
    //           (index) => DataRow(
    //             color: MaterialStateColor.resolveWith((states) {
    //               // Use a color for the heading row based on the current theme
    //               return HexColor('#EFEFFE');
    //             }),
    //             onSelectChanged: (isSelected) {
    //               if (isSelected == true) {
    //                 //data['PaymentStatus'] == "รอตรวจสอบ"
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => PaymentDetailScreen(
    //                         usersFiltered[index]['ReservationId']),
    //                   ),
    //                 );
    //               }
    //             },
    //             cells: [
    //               DataCell(Text(usersFiltered[index]['ReservationId'])),
    //               DataCell(Text(usersFiltered[index]['PaymentStatus'])),
    //             ],
    //           ),
    //         )
    //       : dataList
    //           .map((data) => DataRow(
    //                 color: MaterialStateColor.resolveWith((states) {
    //                   // Use a color for the heading row based on the current theme
    //                   return HexColor('#EFEFFE');
    //                 }),
    //                 onSelectChanged: (isSelected) {
    //                   if (isSelected == true) {
    //                     //data['PaymentStatus'] == "รอตรวจสอบ"
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               PaymentDetailScreen(data['ReservationId'])),
    //                     );
    //                   }
    //                 },
    //                 cells: [
    //                   DataCell(Text(data['ReservationId'])),
    //                   DataCell(Text(data['PaymentStatus'])),
    //                 ],
    //               ))
    //           .toList(),
    // );

    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeAdminScreen()));
          },
        ),
        title: Text('ตรวจสอบการชำระเงิน',
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
                    hintText: 'ค้นหาหมายเลขการจอง',
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
                        .where((data) => data['ReservationId']
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
              // TextButton(
              //     onPressed: () {
              //       _getDataFromFirebase();
              //     },
              //     child: Text('Getdata'))

              Container(
                width: 500,
                height: 500,
                child: ListView(
                  children: [
                    if (dataList.isEmpty)
                      Center(child: Text('ไม่มีข้อมูล')
                          // CircularProgressIndicator(),
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
