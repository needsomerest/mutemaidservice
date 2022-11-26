import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FormInput extends StatelessWidget {
  String title;
  String hint;
  // const LocationForm({super.key});
  FormInput(this.title, this.hint);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 396,
          height: 32,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#5D5FEF').withOpacity(0.2),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: HexColor('#5D5FEF')),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: HexColor('#5D5FEF')),
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
