import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import 'package:mutemaidservice/screen/UserScreen/IndexScreen.dart';

import '../main.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return IndexScreen();
        }
      }),
    );
  }
}
