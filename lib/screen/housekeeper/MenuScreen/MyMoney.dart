import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/ProfileMaidScreen.dart';

class MyMoneyScreen extends StatefulWidget {
  final Maid maid;
  MyMoneyScreen({Key? key, required this.maid}) //required this.addressData
      : super(key: key);

  @override
  State<MyMoneyScreen> createState() => _MyMoneyScreenState();
}

class _MyMoneyScreenState extends State<MyMoneyScreen> {
  // final HousekeeperID = "9U9xNdySRx475ByRhjBw";
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(widget.maid.HousekeeperID)
            .get();
    Map<String, dynamic> UserData = userSnapshot.data()!;
    data.add(UserData);

    print(
        'Number of User documents with Reservation ${widget.maid.HousekeeperID}: ${userSnapshot.data()}');

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {
      // price = dataList[0]['Money'] +
      //     (dataList[2]['PaymentPrice'] * 70 / 100).round();
    });
    print(dataList);
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileMaidScreen(maid: widget.maid)));
          },
        ),
        title: Text('การเงินของฉัน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Housekeeper")
              .doc(widget.maid.HousekeeperID)
              .collection('MoneyHistory')
              .orderBy('Time', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  height: 750,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 500,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: HexColor("#5D5FEF").withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ยอดเงิน',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#5D5FEF')),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/money.png",
                                  height: 75,
                                  width: 75,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${dataList[0]['Money']} บาท',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#000000')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 500,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'รายการธุรกรรม',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#000000')),
                        ),
                      ),
                      Container(
                        height: 400,
                        child: ListView(
                          // scrollDirection: Axis.horizontal
                          children: snapshot.data!.docs.map((HousekeeperDoc) {
                            return ListTile(
                              title: Container(
                                height: 120,
                                width: 500,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: HexColor("BDBDBD").withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ได้รับเงิน',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#000000')),
                                        ),
                                        Text(
                                          'Booking No. ${HousekeeperDoc['BookingNo'].toString().substring(0, 6)}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#979797')),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ค่าบริการ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#000000')),
                                        ),
                                        Text(
                                          '${HousekeeperDoc['Income']} บาท',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#5D5FEF')),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40))),
                  // ),
                ),
              );
              /*ListView(
                // scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((HousekeeperDoc) {
                  return SingleChildScrollView(
                    child: Container(
                      height: 750,
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 500,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: HexColor("#5D5FEF").withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ยอดเงิน',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#5D5FEF')),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/money.png",
                                      height: 75,
                                      width: 75,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '${HousekeeperDoc['Money']} บาท',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#000000')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 500,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              'รายการธุรกรรม',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#000000')),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 500,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: HexColor("BDBDBD").withOpacity(0.25),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ได้รับเงิน',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#000000')),
                                    ),
                                    Text(
                                      'Booking No. ${HousekeeperDoc['BookingNo'].toString().substring(0, 6)}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#979797')),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ค่าบริการ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#000000')),
                                    ),
                                    Text(
                                      '${HousekeeperDoc['Income']} บาท',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#5D5FEF')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      // ),
                    ),
                  );
                }).toList(),
              );*/
            }
          }),

      // SingleChildScrollView(
      //   child: Container(
      //     height: 750,
      //     width: double.infinity,
      //     padding: EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Container(
      //           height: 150,
      //           width: 500,
      //           margin: EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //               color: HexColor("#5D5FEF").withOpacity(0.1),
      //               borderRadius: BorderRadius.circular(20)),
      //           child: Column(
      //             // crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 'ยอดเงิน',
      //                 style: TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     color: HexColor('#5D5FEF')),
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Image.asset(
      //                     "assets/images/money.png",
      //                     height: 75,
      //                     width: 75,
      //                   ),
      //                   SizedBox(
      //                     width: 20,
      //                   ),
      //                   Text(
      //                     '1750 บาท',
      //                     style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: HexColor('#000000')),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //         Container(
      //           height: 50,
      //           width: 500,
      //           alignment: Alignment.centerLeft,
      //           margin: EdgeInsets.only(top: 30),
      //           padding: EdgeInsets.only(left: 30),
      //           child: Text(
      //             'รายการธุรกรรม',
      //             style: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //                 color: HexColor('#000000')),
      //           ),
      //         ),
      //         Container(
      //           height: 120,
      //           width: 500,
      //           margin: EdgeInsets.all(20),
      //           padding: EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //               color: HexColor("BDBDBD").withOpacity(0.25),
      //               borderRadius: BorderRadius.circular(20)),
      //           child: Column(
      //             // crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 // crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     'ได้รับเงิน',
      //                     style: TextStyle(
      //                         fontSize: 24,
      //                         fontWeight: FontWeight.bold,
      //                         color: HexColor('#000000')),
      //                   ),
      //                   Text(
      //                     'Booking No. 061220',
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                         color: HexColor('#979797')),
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 // crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     'ค่าบริการ',
      //                     style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: HexColor('#000000')),
      //                   ),
      //                   Text(
      //                     '1750 บาท',
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                         color: HexColor('#5D5FEF')),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //     decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(
      //             topRight: Radius.circular(40), topLeft: Radius.circular(40))),
      //     // ),
      //   ),
      // ),
    );
  }
}
