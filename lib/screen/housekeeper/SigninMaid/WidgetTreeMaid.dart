// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class WidgetTreeMaidScreen extends StatefulWidget {
//   const WidgetTreeMaidScreen({super.key});

//   @override
//   State<WidgetTreeMaidScreen> createState() => _WidgetTreeMaidScreenState();
// }

// class _WidgetTreeMaidScreenState extends State<WidgetTreeMaidScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Auth().authStateChange,
//       builder: ((context, snapshot) {
//         if (snapshot.hasData) {
//           return VerifyEmailMaidScreen(); //HomeScreen();
//         } else {
//           return IndexAdminScreen(); //Payment(); // //MyBooking(booking); //IndexScreen();
//         }
//       }),
//     );
//   }
// }