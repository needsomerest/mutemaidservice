import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/firebase_options.dart';
import 'package:mutemaidservice/model/notification_managet.dart';
import 'package:mutemaidservice/screen/RoleScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mute Maid Service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Kanit',
            primaryColor: HexColor("#5D5FEF"),
            appBarTheme: AppBarTheme(color: HexColor("#5D5FEF"))),
        home: const RoleScreen());
  }
}
