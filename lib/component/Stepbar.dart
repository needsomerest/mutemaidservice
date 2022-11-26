import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class stepbar extends StatefulWidget {
  // const stepbar({super.key});
  int stepnum;
  stepbar(this.stepnum);
  List<int> steps = [1, 2, 3, 4, 5, 6, 7];
  @override
  State<stepbar> createState() => _stepbarState();
}

class _stepbarState extends State<stepbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: widget.stepnum == 7 ? 280 : ((widget.stepnum - 1) * 48),
              child: Divider(
                color: HexColor('#5D5FEF'),
                thickness: 5,
              ),
            ),
            Container(
              width:
                  widget.stepnum == 7 ? 0 : 280 - ((widget.stepnum - 1) * 48),
              child: Divider(
                color: HexColor('#E6E6E6'),
                thickness: 5,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var step in widget.steps)
              Icon(
                Icons.circle,
                color: step <= widget.stepnum
                    ? HexColor('#5D5FEF')
                    : HexColor('#E6E6E6'),
                size: step <= widget.stepnum ? 24.0 : 16.0,
              )
          ],
        )
      ],
    );
  }
}

// class stepbar extends StatelessWidget {
//   int stepnum;
//   double width1;
//   double width2;
//   stepbar(this.stepnum, this.width1, this.width2);
//   List<int> steps = [1, 2, 3, 4, 5, 6, 7];
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: 10,
//             ),
//             Container(
//               width: width1,
//               child: Divider(
//                 color: HexColor('#5D5FEF'),
//                 thickness: 5,
//               ),
//             ),
//             Container(
//               width: width2,
//               child: Divider(
//                 color: HexColor('#E6E6E6'),
//                 thickness: 5,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             for (var step in steps)
//               Icon(
//                 Icons.circle,
//                 color:
//                     step <= stepnum ? HexColor('#5D5FEF') : HexColor('#E6E6E6'),
//                 size: step <= stepnum ? 24.0 : 16.0,
//               )
//           ],
//         )
//       ],
//     );
//   }
// }

// class stepbar extends StatefulWidget {
//   // const stepbar({super.key});
//   final int stepnum;
//   const stepbar({Key? key, required this.stepnum}) : super(key: key);
//   // const stepbar(this.stepnum);

//   @override
//   State<stepbar> createState() => _stepbarState();
// }

// class _stepbarState extends State<stepbar> {
//   @override
//   Widget build(BuildContext context) {
//     List<int> steps = [1, 2, 3, 4, 5, 6, 7];
//     ;
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: 290,
//           child: Divider(
//             color: HexColor('#E6E6E6'),
//             thickness: 5,
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             for (var step in steps)
//               Icon(
//                 Icons.circle,
//                 color: step == ${stepnum} ? HexColor('#5D5FEF') : HexColor('#E6E6E6'),
//                 size: step == ${stepnum} ? 24.0 : 16.0,
//               )
//           ],
//         )
//       ],
//     );
//   }
// }
