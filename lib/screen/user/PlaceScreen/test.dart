// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:mutemaidservice/component/DropdownArea.dart';

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor('#5D5FEF'),
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: HexColor('#5D5FEF'),
//         centerTitle: true,
//         leading: Icon(
//           Icons.keyboard_backspace,
//           color: Colors.white,
//           size: 30,
//         ),
//         title: Text(
//             widget.edit == false
//                 ? 'เพิ่มสถานที่ใช้บริการ'
//                 : 'แก้ไขสถานที่ของฉัน',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: widget.edit == false ? 1110 : 1060,
//           width: double.infinity,
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               if (widget.edit == false) ...[
//                 widget.booking == true
//                     ? Container(
//                         width: 300.0,
//                         margin: EdgeInsets.only(top: 30),
//                         child: stepbar(3),
//                       )
//                     : SizedBox(height: 30),
//               ],
//               SizedBox(height: 30),
//               Text(
//                 'เลือกประเภทที่พักของคุณ\nเพื่อประสิทธิภาพในการประเมินราคาที่ดีที่สุด',
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               if (widget.typecondo == true) ...[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           color: HexColor('#FFFFFF'),
//                           border: Border.all(
//                               width: 2.0, color: HexColor('#5D5FEF')),
//                           // border: Colors.blueAccent,
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'คอนโด/หอพัก',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Image.asset(
//                             "assets/images/condo.png",
//                             height: 76,
//                             width: 76,
//                           )
//                         ],
//                       ),
//                     ),
//                     // SizedBox(width: 20),
//                     InkWell(
//                         child: Container(
//                           margin: EdgeInsets.all(20),
//                           width: 130,
//                           height: 130,
//                           decoration: BoxDecoration(
//                               color: HexColor('#FFFFFF'),
//                               border: Border.all(color: HexColor('#BDBDBD')),
//                               // border: Colors.blueAccent,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'ทาว์นโฮม/บ้านเดี่ยว',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Image.asset(
//                                 "assets/images/home.png",
//                                 height: 70,
//                                 width: 70,
//                               )
//                             ],
//                           ),
//                         ),
//                         onTap: () {
//                           /* */
//                           newAddressData.Type = 'home';
//                           setState(() {
//                             widget.typecondo = false;
//                           });
//                         })
//                   ],
//                 ),
//               ] else ...[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                         child: Container(
//                           margin: EdgeInsets.all(20),
//                           width: 130,
//                           height: 130,
//                           decoration: BoxDecoration(
//                               color: HexColor('#FFFFFF'),
//                               border: Border.all(color: HexColor('#BDBDBD')),
//                               // border: Colors.blueAccent,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'คอนโด/หอพัก',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Image.asset(
//                                 "assets/images/condo.png",
//                                 height: 76,
//                                 width: 76,
//                               )
//                             ],
//                           ),
//                         ),
//                         onTap: () {
//                           /* */
//                           newAddressData.Type = 'condo';
//                           setState(() {
//                             widget.typecondo = true;
//                           });
//                         }),
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           color: HexColor('#FFFFFF'),
//                           border: Border.all(
//                               width: 2.0, color: HexColor('#5D5FEF')),
//                           // border: Colors.blueAccent,
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'ทาว์นโฮม/บ้านเดี่ยว',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Image.asset(
//                             "assets/images/home.png",
//                             height: 70,
//                             width: 70,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//               Container(
//                 margin: EdgeInsets.all(20),
//                 // alignment: Alignment.centerRight,
//                 width: 300,
//                 // color: Colors.white,
//                 height: 50,
//                 child: DropdownArea(
//                   addressData: newAddressData,
//                 ),
//               ),
//               Container(
//                 height: 718,
//                 width: double.infinity,
//                 child: LocationForm(
//                   booking: widget.booking == true ? true : false,
//                   addressData: newAddressData,
//                 ),
//               ),
//             ],
//           ),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(40), topLeft: Radius.circular(40))),
//           // ),
//         ),
//       ),
//     );
//   }
// }