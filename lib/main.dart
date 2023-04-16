import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/BottomNavbar.dart';
import 'package:mutemaidservice/firebase_options.dart';
import 'package:mutemaidservice/model/widget_tree.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import 'package:mutemaidservice/screen/RoleScreen.dart';
import 'package:mutemaidservice/screen/TestData.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/Login/login.dart';
import 'package:mutemaidservice/screen/housekeeper/Login/loginwithphone.dart';
import 'package:mutemaidservice/screen/housekeeper/Login/verify.dart';
import 'package:mutemaidservice/screen/housekeeper/MapScreen/RouteMapScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidSigninScreen.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/map.dart';
import 'package:provider/provider.dart';

import 'model/auth_provider.dart';
import 'screen/housekeeper/Login/phone.dart';
import 'screen/housekeeper/SigninMaid/welcome_screen.dart';
//void main() => runApp(const MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Mute Maid Service';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Kanit',
            primaryColor: HexColor("#5D5FEF"),
            appBarTheme: AppBarTheme(color: HexColor("#5D5FEF"))),
        home: MaidSigninScreen()
        // initialRoute: 'phone',
        // routes: {
        //   'phone': (context) => MyPhone(),
        //   'verify': (context) => MyVerify(),
        //   'home': (context) => HomeMaidScreen(),
        // },
        );
    //const RoleScreen()); HomeMaidScreen()
    // home: HomeMaidScreen()); EventCalendarScreen() HomeMaidScreen RouteMapPage
    // home: LoginScreen());
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavbar();
//   }
// }
