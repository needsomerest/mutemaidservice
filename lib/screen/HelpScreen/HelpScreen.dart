import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/SignVideoDetail.dart';
import 'package:mutemaidservice/component/SignVideoList.dart';
import 'package:mutemaidservice/screen/BookingScreen/MyBooking.dart';
import 'package:mutemaidservice/screen/ChatScreen/ChatScreen.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import '../../component/VideoCard.dart';
import '../../component/assetplayer.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List searchRusult = [];
  final List<String> _filters = <String>[];

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('SignLanguageVideo')
        .where('Tag', arrayContains: query)
        .get();
    searchRusult = result.docs.map((e) => e.data()).toList();

    setState(() {
      searchRusult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final _focusNode = FocusNode();

  bool _isTyping = false;
  bool _isShow = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isTyping = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3;
    final screens = [HomeScreen(), MyBooking(), ChatScreen(), HelpScreen()];
    List<String> hints = [
      "ห้องครัว",
      "ห้องน้ำ",
      "ห้องพระ",
      "ห้องทำงาน",
      "ห้องนั่งเล่น",
      "นอกอาคาร",
      "ชั้นอาคาร",
      "ซักรีด",
      "ทำความสะอาด",
      "สัตว์เลี้ยง",
      "เฟอร์นิเจอร์",
      "อื่นๆ",
    ];

    List<FilterChip> filterhints = hints.map((item) {
      return FilterChip(
        selectedColor: HexColor('DFDFFC'),
        backgroundColor: HexColor('F1F1F1'),
        showCheckmark: false,
        label: Text(item),
        labelStyle: TextStyle(
            color: HexColor('5D5FEF'),
            fontSize: 12,
            fontWeight: FontWeight.bold),
        selected: _filters.contains(item),
        onSelected: (bool value) {
          setState(() {
            if (value) {
              if (!_filters.contains(item)) {
                _filters.clear();
                _filters.add(item);
              }
            } else {
              _filters.removeWhere((String name) {
                return name == item;
              });
            }
          });
        },
      );
    }).toList();

    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        title: Text('ช่วยเหลือ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 720,
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(children: [
              Container(
                height: 60,
                width: 400,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ล่ามภาษามือ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      "assets/images/messageImage.png",
                      height: 54,
                      width: 54,
                    ),

                    // Image.asset("assets/images/messageImage.png"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: TextFormField(
                  cursorColor: HexColor("#5D5FEF"),
                  textAlign: TextAlign.left,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: '  ค้นหา...',
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                        //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                      ),
                    ),
                    filled: true,
                    fillColor: HexColor("F1F1F1"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: HexColor("#5D5FEF"),

                        //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                      ),
                    ),
                  ),
                  onChanged: (query) {
                    searchFromFirebase(query);
                  },
                ),
              ),
              Visibility(
                  visible: !_isTyping,
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.filter_alt,
                                      color: HexColor('5D5FEF'),
                                    ),
                                    Text('ตัวกรอง',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: HexColor('5D5FEF'),
                                        )),
                                    Icon(
                                      _isShow
                                          ? Icons.arrow_drop_down_rounded
                                          : Icons.arrow_drop_up_rounded,
                                      color: HexColor('5D5FEF'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(
                              () {
                                _isShow = !_isShow;
                              },
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Divider(
                            color: HexColor("DDDDDD"),
                            height: 20,
                          ),
                        ),
                        Visibility(
                          visible: _isShow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.topCenter,
                                child: Wrap(
                                  spacing: 8.0,
                                  children: filterhints,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        SignVideoList(
                            _filters.isEmpty
                                ? 'User'
                                : _filters.first.toString(),
                            _isShow),
                      ],
                    ),
                  )),
              Expanded(
                  child: ListView.builder(
                      itemCount: searchRusult.length,
                      itemBuilder: (context, index) {
                        return SignVideoDetail(searchRusult[index]['Name'],
                            searchRusult[index]['Url']);
                      })),
            ]),
          ),
        ),
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
