import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/IndexAdminScreen.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/SiginAdminScreen.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/VerifyEmailAdminScreen.dart';
import 'package:mutemaidservice/screen/user/UserScreen/IndexScreen.dart';
import 'package:mutemaidservice/screen/user/UserScreen/VerifyEmailScreen.dart';

// import '../main.dart';

class WidgetTreeAdmin extends StatefulWidget {
  const WidgetTreeAdmin({super.key});

  @override
  State<WidgetTreeAdmin> createState() => _WidgetTreeAdminState();
}

class _WidgetTreeAdminState extends State<WidgetTreeAdmin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return VerifyEmailAdminScreen(); //HomeScreen();
        } else {
          return IndexAdminScreen(); //Payment(); // //MyBooking(booking); //IndexScreen();
        }
      }),
    );
  }
}
