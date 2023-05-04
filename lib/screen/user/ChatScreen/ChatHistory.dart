import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatScreen.dart';
import '../../../component/ChatAtom.dart';
import '../../HomeScreen.dart';
import '../BookingScreen/MyBooking.dart';
import '../HelpScreen/HelpScreen.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class Message {
  final String id;
  final String sender;
  final String receiver;
  final String text;
  final Timestamp timestamp;

  Message(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.text,
      required this.timestamp});
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  List<Map<String, dynamic>> mergedDataList = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? user = Auth().currentUser;
  late String uid = '';

  String gencode(String sender, String receiver) {
    String code = "";
    int comparisonResult = sender.compareTo(receiver);
    if (comparisonResult > 0) {
      code = "${sender.substring(0, 5)}${receiver.substring(0, 5)}";
      print(code);
    } else if (comparisonResult < 0) {
      code = "${receiver.substring(0, 5)}${sender.substring(0, 5)}";
      print(code);
    } else {
      code = "${sender.substring(0, 5)}${receiver.substring(0, 5)}";
      print(code);
    }
    return code;
  }

  Future<List<Message>> getLatestMessages(String uid) async {
    QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
        await FirebaseFirestore.instance
            .collection("Messages")
            .where('sender', isEqualTo: uid)
            .get();
    List<String> uniqueReceivers = messagesSnapshot.docs
        .map((doc) => doc['receiver'])
        .toSet()
        .toList()
        .cast<String>();
    List<Message> latestMessages = [];
    for (String receiver in uniqueReceivers) {
      String code = gencode(uid, receiver);
      QuerySnapshot<Map<String, dynamic>> subQuerySnapshot =
          await FirebaseFirestore.instance
              .collection('Messages')
              .where('code', isEqualTo: code)
              // .where('sender', isEqualTo: uid)
              // .where('receiver', isEqualTo: receiver)
              .orderBy('time', descending: true)
              .limit(1)
              .get();
      if (subQuerySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> messageDoc =
            subQuerySnapshot.docs[0];
        Message message = Message(
            id: messageDoc.id,
            sender: messageDoc['sender'],
            receiver: messageDoc['receiver'],
            text: messageDoc['message'],
            timestamp: messageDoc['time']);
        latestMessages.add(message);
      }
    }
    return latestMessages;
  }

  List<Message> latestMessages = [];
  List<Map<String, dynamic>> data = [];
  Future<List<Map<String, dynamic>>> getHousekeeperSnapshots(String uid) async {
    latestMessages = await getLatestMessages(uid);
    for (Message message in latestMessages) {
      String receiver;
      if (message.receiver != uid) {
        receiver = message.receiver;
      } else {
        receiver = message.sender;
      }
      DocumentSnapshot<Map<String, dynamic>> housekeeperSnapshot =
          await FirebaseFirestore.instance
              .collection('Housekeeper')
              .doc(receiver)
              .get();
      if (housekeeperSnapshot.exists) {
        Map<String, dynamic> housekeeperData = housekeeperSnapshot.data()!;
        housekeeperData['housekeeperId'] = receiver;
        // dataList.add(housekeeperData);
        // print(dataList.length);
        // for (int i = 0; i < dataList.length; i++) {
        //   String receiver = dataList[i]['housekeeperId'];
        // if (message.receiver == receiver) {
        Map<String, dynamic> mergedData =
            Map<String, dynamic>.from(housekeeperData);
        mergedData['latestMessageId'] = message.id;
        mergedData['latestMessageText'] = message.text;
        mergedData['latestMessageTimestamp'] = message.timestamp;
        mergedDataList.add(mergedData);
      }

      // }
      // }
      // print(dataList.length);
    }
    // print(mergedDataList.length);
    // for (int i = 0; i < mergedDataList.length; i++) {
    //   print(mergedDataList[i]);
    // }
    return mergedDataList;
  }

  @override
  void initState() {
    super.initState();
    final _uid = user?.uid;
    setState(() {
      uid = _uid.toString();
    });
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    data = await getHousekeeperSnapshots(uid);
    print(data.length);
    for (int i = 0; i < data.length; i++) {
      print(data[i]);
    }
    if (mounted) {
      setState(() {});
    }

    // print(data);
    // print(dataList);
  }

  // final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    // final _uid = user?.uid;
    // String uid = _uid.toString();
    int _selectedIndex = 2;
    final screens = [
      HomeScreen(),
      MyBooking(),
      ChatHistoryScreen(),
      HelpScreen()
    ];
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        title: Text('ข้อความ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 900,
          // constraints: BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: mergedDataList.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(index.toString());
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // test()
                                    // chatpage("ZhkVnQ10zU28sFaURHU6", uid)
                                    ChatScreen(
                                        uid, data[index]['housekeeperId'])));
                      },
                      child: ChatAtom(
                          data[index]['profileImage'],
                          "${data[index]['FirstName']} ${data[index]['LastName']}",
                          data[index]['latestMessageText']),
                    );
                  })
              // : CircularProgressIndicator()
              : Center(
                  child: Text("ยังไม่มีรายการ"),
                ),

          // child:dataList['housekeeperId']==latestMessages['Receiver']?Text("yes"):Text("no")
          //: InkWell(
          //   child:
          //   Column(
          //     children: [
          //     ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
          //         "กำลังจะไปถึงค่ะ"),
          // ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
          //         "กำลังจะไปถึงค่ะ"),
          //     ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
          //         "กำลังจะไปถึงค่ะ"),
          //   ]),
          //   onTap: () {
          //     // Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) =>
          //     //             // test()
          //     //             // chatpage("ZhkVnQ10zU28sFaURHU6", uid)
          //     //             ChatScreen(uid, "ZhkVnQ10zU28sFaURHU6")));
          //   },
          // ),
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
                  text: 'ช่วยเหลือ',
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
// class ChatHistory extends StatelessWidget {
//   // const ChatHistory({super.key});
//   List<bool> side_sender = [false, true, false, true, true];
//   // Chatside(this.side_sender);
//   final User? user = Auth().currentUser;
//   final fs = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   final TextEditingController message = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final _uid = user?.uid;
//     String uid = _uid.toString();
//     int _selectedIndex = 2;
//     final screens = [
//       HomeScreen(),
//       MyBooking([3, 5]),
//       ChatHistory(),
//       HelpScreen()
//     ];
//     return Scaffold(
//       backgroundColor: HexColor('#5D5FEF'),
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: HexColor('#5D5FEF'),
//         centerTitle: true,
//         // leading:
//         //     // GestureDetector(
//         //     //   onTap: () {
//         //     //     Navigator.push(
//         //     //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//         //     //   }, child:
//         //     Icon(
//         //   Icons.keyboard_backspace,
//         //   color: Colors.white,
//         //   size: 30,
//         // ),
//         // ),
//         //  Icon(
//         //     Icons.keyboard_backspace,
//         //     color: Colors.white,
//         //   ),
//         title: Text('ข้อความ',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           height: 900,
//           // constraints: BoxConstraints(maxWidth: 300),
//           decoration: BoxDecoration(
//               color: HexColor('#FFFFFF'),
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30), topLeft: Radius.circular(30))),
//           child: InkWell(
//             child: Column(children: [
//               ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
//                   "กำลังจะไปถึงค่ะ"),
//               ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
//                   "กำลังจะไปถึงค่ะ"),
//               ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
//                   "กำลังจะไปถึงค่ะ"),
//             ]),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           chatpage(uid, "ZhkVnQ10zU28sFaURHU6")));
//             },
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               rippleColor: Colors.grey[300]!,
//               hoverColor: Colors.grey[100]!,
//               gap: 8,
//               activeColor: Colors.black,
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Colors.grey[100]!,
//               color: Colors.black,
//               tabs: [
//                 GButton(
//                   icon: LineIcons.home,
//                   text: 'หน้าหลัก',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//                 GButton(
//                   icon: LineIcons.book,
//                   text: 'การจองของฉัน',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//                 GButton(
//                   icon: LineIcons.rocketChat,
//                   text: 'การสนทนา',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//                 GButton(
//                   icon: LineIcons.video,
//                   text: 'ช่วยเหลือ',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => screens[_selectedIndex]));
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
