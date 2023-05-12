import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:mcs_app/screen/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:mutemaidservice/screen/BookingScreen/MyBooking.dart';
import 'package:mutemaidservice/screen/ChatScreen/ChatScreen.dart';
import 'package:mutemaidservice/screen/HelpScreen/HelpScreen.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';

//void main() => runApp(const MyApp());

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   static const String _title = 'MCS Service';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: _title,
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//             fontFamily: 'Kanit',
//             primaryColor: HexColor("#5D5FEF"),
//             appBarTheme: AppBarTheme(color: HexColor("#5D5FEF"))),
//         home: WidgetTree());
//   }
// }

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  final screens = [HomeScreen(), MyBooking(), ChatScreen(), HelpScreen()];
  // final screens = [HomeScreen(), booking(false), ChatScreen(), HelpScreen()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'การจองของฉัน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'การสนทนา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_front),
            label: 'ภาษามือ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
