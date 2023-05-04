import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/BookingScreen.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/MyBooking.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatHistory.dart';
import 'package:mutemaidservice/screen/user/HelpScreen/HelpScreen.dart';
import '../component/CardPromotion.dart';
import '../component/ProfileBar.dart';
import '../component/PromotionCardSlide.dart';
import '../model/auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      "");

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

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    final screens = [
      HomeScreen(),
      MyBooking(),
      ChatHistoryScreen(),
      HelpScreen()
    ];
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 200,
            child: ProfileBar(),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20),
            child: Text(
              'การบริการ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          InkWell(
            child: Container(
              height: 250,
              width: 300,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: HexColor("#5D5FEF").withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/booking_1.png",
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'ทำความสะอาดบ้าน',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#06161C')),
                  ),
                  Text('(ตามความต้องการ)',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#5D5FEF'))),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#5D5FEF"),
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: Size(130, 40),
                    ),
                    child: Text(
                      'จองบริการ',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingScreen(
                                    housekeeper: newHousekeeper,
                                    addressData: newAddress,
                                    reservationData: newReservationData,
                                    backward: false,
                                  )));
                    },
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingScreen(
                            addressData: newAddress,
                            housekeeper: newHousekeeper,
                            reservationData: newReservationData,
                            backward: false,
                          )));
            },
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_outlined,
                        color: HexColor('5D5FEF'),
                      ),
                      Text(
                        'ใช้ดีบอกต่อ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            height: 230,
            child: PromotionCardSlide(),
          ),
        ],
      )),
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
                  icon: LineIcons.book,
                  text: 'การจองของฉัน',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  text: 'การสนทนา',
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
    );
  }
}
