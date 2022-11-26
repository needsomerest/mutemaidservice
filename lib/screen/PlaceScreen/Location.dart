// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'HomeScreen.dart';
// import 'BookingHistory.dart';

// class Location extends StatelessWidget {
//   const Location({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor('#5D5FEF'),
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: HexColor('#5D5FEF'),
//         centerTitle: true,
//         leading:
//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.push(
//             //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//             //   }, child:
//             Icon(
//           Icons.keyboard_backspace,
//           color: Colors.white,
//           size: 30,
//         ),
//         // ),
//         //  Icon(
//         //     Icons.keyboard_backspace,
//         //     color: Colors.white,
//         //   ),
//         title: Text('เพิ่มสถานที่ใช้บริการ',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           height: 700,
//           // constraints: BoxConstraints(maxWidth: 300),
//           decoration: BoxDecoration(
//               color: HexColor('#FFFFFF'),
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30), topLeft: Radius.circular(30))),
//           child: Container(
//             child: Column(children: [
//               Container(
//                 height: 50,
//                 width: 500,
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.only(top: 50),
//                 child: ElevatedButton.icon(
//                   icon: Icon(
//                     Icons.add,
//                     color: Colors.white,
//                     size: 30.0,
//                   ),
//                   label: Text(
//                     'เพิ่มสถานที่ใช้บริการ',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     alignment: Alignment.center,
//                     backgroundColor: HexColor("#5D5FEF"),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40.0),
//                     ),
//                     minimumSize: Size(100, 40),
//                   ),
//                   // child: Text(
//                   //   'เพิ่มสถานที่ใช้บริการ',
//                   //   style: TextStyle(fontSize: 16),
//                   // ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         // MaterialPageRoute(builder: (context) => HomeScreen()));
//                         MaterialPageRoute(
//                             builder: (context) => BookingHistory()));
//                   },
//                 ),
//               )
//             ]),
//             width: 400,
//             height: 700,
//             // constraints: BoxConstraints(maxWidth: 300),
//             decoration: BoxDecoration(
//                 color: Colors.lightBlueAccent,
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     topLeft: Radius.circular(30))),
//           ),
//         ),
//       ),
//     );
//   }
// }
