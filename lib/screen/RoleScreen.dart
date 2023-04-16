// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mutemaidservice/component/CardRole.dart';
import 'package:mutemaidservice/model/widget_tree.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/HomeScreen.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/SiginAdminScreen.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/widget_tree_admin.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/Login/VerifyTelScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidSigninScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/Phone.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WidgetTreeAdmin()));
            },
            child: CardRole("assets/images/adminrole.png", "Admin"),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MaidSigninScreen()));
            },
            child: CardRole("assets/images/maidrole.png", "Housekeeper"),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WidgetTree()));
            },
            child: CardRole("assets/images/userrole.png", "Costumer"),
          ),
        ],
      ),
    );
  }
}
