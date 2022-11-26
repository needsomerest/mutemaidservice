import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/PlaceAtom.dart';
import '../BookingScreen/MyBooking.dart';
import 'AddPlaceScreen.dart';
import '../../component/Stepbar.dart';

class Myplace extends StatefulWidget {
  List<int> place;
  bool book;
  Myplace(this.place, this.book);
  // const Myplace({super.key});

  @override
  State<Myplace> createState() => _MyplaceState();
}

class _MyplaceState extends State<Myplace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          leading:
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
              //   }, child:
              Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          // ),
          //  Icon(
          //     Icons.keyboard_backspace,
          //     color: Colors.white,
          //   ),
          title: Text('สถานที่ของฉัน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 700,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(children: [
              if (widget.book == true) ...[
                Container(
                  width: 300.0,
                  margin: EdgeInsets.only(top: 30),
                  child: stepbar(2),
                ),
              ] else ...[
                SizedBox(
                  height: 30,
                )
              ],
              if (widget.place.length >= 1) ...[
                Container(
                  width: 400,
                  height: 500,
                  // height: widget.place.length % 2 == 0
                  //     ? widget.place.length * 100
                  //     : (widget.place.length + 1) * 100,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: <Widget>[
                      for (var place in widget.place)
                        PlaceAtom("บ้านที่บางมด", "assets/images/ex.home.jpg"),
                    ],
                  ),
                )
              ],
              Container(
                height: 50,
                width: 500,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: Text(
                    'เพิ่มสถานที่ใช้บริการ',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: HexColor("#5D5FEF"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    minimumSize: Size(100, 40),
                  ),
                  // child: Text(
                  //   'เพิ่มสถานที่ใช้บริการ',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => Addpace()));
                        MaterialPageRoute(
                            builder: (context) => Addplace(false)));
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
// class Myplace extends StatelessWidget {
//   const Myplace({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: HexColor('#5D5FEF'),
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: HexColor('#5D5FEF'),
//           centerTitle: true,
//           leading:
//               // GestureDetector(
//               //   onTap: () {
//               //     Navigator.push(
//               //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//               //   }, child:
//               Icon(
//             Icons.keyboard_backspace,
//             color: Colors.white,
//             size: 30,
//           ),
//           // ),
//           //  Icon(
//           //     Icons.keyboard_backspace,
//           //     color: Colors.white,
//           //   ),
//           title: Text('สถานที่ของฉัน',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             height: 730,
//             // constraints: BoxConstraints(maxWidth: 300),
//             decoration: BoxDecoration(
//                 color: HexColor('#FFFFFF'),
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     topLeft: Radius.circular(30))),
//             child: Column(children: [
//               Container(
//                 width: 300.0,
//                 margin: EdgeInsets.only(top: 30),
//                 child: stepbar(2),
//               ),
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
//                         // MaterialPageRoute(builder: (context) => Addpace()));
//                         MaterialPageRoute(builder: (context) => Addplace()));
//                   },
//                 ),
//               )
//             ]),
//           ),
//         ));
//   }
// }
