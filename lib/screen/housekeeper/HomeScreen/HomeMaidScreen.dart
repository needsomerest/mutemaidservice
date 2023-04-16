// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/BottomNavbar.dart';
import 'package:mutemaidservice/component/ProfilemaidBar.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/ChatMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/chatpage.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/UserManual.dart';
import '../../../../component/CardPromotion.dart';
import '../../../../component/ProfileBar.dart';
import '../../../../component/PromotionCardSlide.dart';
import '../../../../model/auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import '../../../RoleScreen.dart';
import '../ScheduleScreen/ScheduleScreen.dart';

class HomeMaidScreen extends StatefulWidget {
  // HomeMaidScreen(String housekeeperID);

  const HomeMaidScreen({super.key});
  // final User? user = Auth().currentUser;
  // String HousekeeperID;
  // HomeMaidScreen(this.HousekeeperID);
  @override
  State<HomeMaidScreen> createState() => _HomeMaidScreenState();
}

class _HomeMaidScreenState extends State<HomeMaidScreen> {
  final HousekeeperID = "9U9xNdySRx475ByRhjBw";
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> HousekeeperSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(HousekeeperID)
            .get();
    Map<String, dynamic> HousekeeperData = HousekeeperSnapshot.data()!;
    data.add(HousekeeperData);

    print(
        'Number of User documents with Reservation ${HousekeeperID}: ${HousekeeperSnapshot.data()}');

    // DocumentSnapshot<Map<String, dynamic>> reservationSnapshot =
    //     await userSnapshot.reference
    //         .collection('Reservation')
    //         .doc(widget.Reservid)
    //         .get();

    // Map<String, dynamic> reservationData = reservationSnapshot.data()!;
    // data.add(reservationData);

    // print(
    //     'Number of Reservation documents with ID ${widget.Reservid}: ${reservationSnapshot.data}');

    // // Get the Payment subcollection for this Reservation document
    // QuerySnapshot<Map<String, dynamic>> paymentSnapshot =
    //     await reservationSnapshot.reference.collection('Payment').get();

    // print(
    //     'Number of Payment documents with PaymentStatus=true in Reservation document ${reservationSnapshot.id}: ${paymentSnapshot.size}');

    // for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
    //     in paymentSnapshot.docs) {
    //   Map<String, dynamic> docData = paymentDoc.data();
    //   docData['ReservationId'] = reservationSnapshot.id;
    //   Paymentid = paymentDoc.id;
    //   data.add(docData);
    // }

    // DocumentSnapshot<Map<String, dynamic>> maidSnapshot =
    //     await FirebaseFirestore.instance
    //         .collection('Housekeeper')
    //         .doc(widget.Housekeeperid)
    //         .get();
    // Map<String, dynamic> MaidData = maidSnapshot.data()!;
    // data.add(MaidData);

    // print(
    //     'Number of User documents with Reservation ${widget.Housekeeperid} : ${maidSnapshot.data()}');

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
    setState(() {});
    print(dataList);
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    final screens = [
      HomeMaidScreen(),
      ScheduleScreen(),
      ChatMaidScreen(),
      // ChatMaidScreen(),
    ];
    return Scaffold(
      body: dataList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // Center(
                //   child: Text(dataList[0]['Money'].toString()),
                // )

                Container(
                  height: 200,
                  child: ProfileMaidBar(
                    dataList[0]['FirstName'].toString(),
                    dataList[0]["LastName"].toString(),
                    dataList[0]["profileImage"].toString(),
                    dataList[0]['HousekeeperID'].toString(),
                  ),
                ),
                Container(
                  height: 300,
                  width: 400,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: HexColor("#5D5FEF").withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ยอดเงิน',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#5D5FEF')),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/money.png",
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${dataList[0]['Money'].toString()}",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#000000')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: 400,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: HexColor("#5D5FEF").withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#5D5FEF"),
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(130, 40),
                    ),
                    child: Text(
                      'รับงาน',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // _getDataFromFirebase();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserManual()));
                    },
                  ),
                ),
              ],
            ),

      //       child: Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       child: ProfileMaidBar(),
      //     ),
      //     Container(
      //       height: 300,
      //       width: 400,
      //       margin: EdgeInsets.all(20),
      //       decoration: BoxDecoration(
      //           color: HexColor("#5D5FEF").withOpacity(0.1),
      //           borderRadius: BorderRadius.circular(20)),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(
      //             'ยอดเงิน',
      //             style: TextStyle(
      //                 fontSize: 24,
      //                 fontWeight: FontWeight.bold,
      //                 color: HexColor('#5D5FEF')),
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             // crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Image.asset(
      //                 "assets/images/money.png",
      //                 height: 100,
      //                 width: 100,
      //               ),
      //               SizedBox(
      //                 width: 20,
      //               ),
      //               Text(
      //                 '1750 บาท',
      //                 style: TextStyle(
      //                     fontSize: 35,
      //                     fontWeight: FontWeight.bold,
      //                     color: HexColor('#000000')),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       height: 70,
      //       width: 400,
      //       margin: EdgeInsets.all(20),
      //       decoration: BoxDecoration(
      //           color: HexColor("#5D5FEF").withOpacity(0.1),
      //           borderRadius: BorderRadius.circular(4)),
      //       child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: HexColor("#5D5FEF"),
      //           padding: EdgeInsets.all(15),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //           ),
      //           minimumSize: Size(130, 40),
      //         ),
      //         child: Text(
      //           'รับงาน',
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => UserManual()));
      //         },
      //       ),
      //     ),
      //   ],
      // )

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'หน้าหลัก',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.calendar,
                  text: 'ตารางงาน',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  text: 'ข้อความ',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screens[_selectedIndex]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
