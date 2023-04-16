import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/housekeeper/Login/VerifyTelScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidSigninScreen.dart';

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
          return VerifyTelScreen(); //HomeScreen();
        } else {
          return MaidSigninScreen(); //Payment(); // //MyBooking(booking); //IndexScreen();
        }
      }),
    );
  }
}
