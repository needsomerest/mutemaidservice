import 'package:flutter/material.dart';
import 'package:mutemaidservice/screen/BookingScreen/MyBooking.dart';
import 'package:mutemaidservice/screen/ChatScreen/ChatScreen.dart';
import 'package:mutemaidservice/screen/HelpScreen/HelpScreen.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'MMS Service';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  final screens = [HomeScreen(), MyBooking(), ChatScreen(), HelpScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MMS Service'),
      ),
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
            icon: Icon(Icons.settings),
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
