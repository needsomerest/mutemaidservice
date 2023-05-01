import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninScreen/IndexMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninScreen/VerifyEmailMaidScreen.dart';

// import '../main.dart';

class WidgetTreeMaid extends StatefulWidget {
  const WidgetTreeMaid({super.key});

  @override
  State<WidgetTreeMaid> createState() => _WidgetTreeMaidState();
}

class _WidgetTreeMaidState extends State<WidgetTreeMaid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return VerifyEmailMaidScreen(); //HomeScreen();
        } else {
          return IndexMaidScreen(); //Payment(); // //MyBooking(booking); //IndexScreen();
        }
      }),
    );
  }
}
