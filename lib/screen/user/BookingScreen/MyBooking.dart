import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/MybookingList.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatHistory.dart';
import '../../HomeScreen.dart';
import '../HelpScreen/HelpScreen.dart';

class MyBooking extends StatefulWidget {
  // const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  final newReservationData = new ReservationData(
    "",
    "",
    DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
    "14:30",
    "",
    "2 ชม. แนะนำ",
    Duration(
      hours: 0,
    ),
    "ครั้งเดียว",
    "เปลี่ยนผ้าคลุมเตียงและปลอกหมอน",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "ไม่มี",
    "",
    GeoPoint(0.0, 0.0),
    "",
    "",
    "",
    "กำลังตรวจสอบ",
    true,
    "",
  );

  final newHousekeeper = Housekeeper("HousekeeperID", "FirstName", "LastName",
      "ProfileImage", 0, 0, 0, "CommunicationSkill", "PhoneNumber");

  final newAddress = AddressData(
      "AddressID",
      "Addressimage",
      "Type",
      "SizeRoom",
      "Address",
      "AddressDetail",
      "Province",
      "District",
      "Phonenumber",
      "Note",
      "User",
      GeoPoint(0, 0));

  Future<bool> CheckCollection(String UserID) async {
    final CollectionReference usersRef = FirebaseFirestore.instance
        .collection('User')
        .doc(UserID)
        .collection('Reservation');
    bool collectionExists = false;

    usersRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.exists) {
          collectionExists = true;
        }
      });
    });
    return collectionExists;
  }

  int _selectedIndex = 1;
  final screens = [
    HomeScreen(),
    MyBooking(),
    ChatHistoryScreen(),
    HelpScreen()
  ];
  final User? user = Auth().currentUser;

  TabBar get _tabBar => TabBar(
        labelColor: HexColor('#5D5FEF'), //<-- selected text color
        unselectedLabelColor: HexColor('#BDBDBD'),
        indicatorColor: HexColor('#5D5FEF'),
        tabs: [
          Tab(
            text: 'กำลังมาถึง',
          ),
          Tab(
            text: 'ดำเนินการ',
          ),
          Tab(
            text: 'เสร็จสิ้น',
          ),
          Tab(
            text: 'ประวัติ',
          ),
        ],
      );
  bool ischeck = false;

  Widget build(BuildContext context) {
    final UserID = user?.uid;

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          title: Text('การจองของฉัน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },

          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: HexColor('#FFFFFF'),
              child: _tabBar,
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MyBookingList(
              UserID: UserID.toString(),
              TabStatus: 'กำลังมาถึง',
            ),
            MyBookingList(
              UserID: UserID.toString(),
              TabStatus: 'กำลังดำเนินการ',
            ),
            MyBookingList(
              UserID: UserID.toString(),
              TabStatus: 'เสร็จสิ้น',
            ),
            MyBookingList(
              UserID: UserID.toString(),
              TabStatus: 'ประวัติ',
            ),
          ],
        ),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                    icon: LineIcons.book,
                    text: 'การจองของฉัน',
                    iconActiveColor: HexColor('5D5FEF'),
                    textColor: HexColor('5D5FEF'),
                    backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                  ),
                  GButton(
                    icon: LineIcons.rocketChat,
                    text: 'แชท',
                    iconActiveColor: HexColor('5D5FEF'),
                    textColor: HexColor('5D5FEF'),
                    backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                  ),
                  GButton(
                    icon: LineIcons.video,
                    text: 'ภาษามือ',
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
      ),
    );
  }
}
