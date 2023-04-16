import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';

class FormInput extends StatelessWidget {
  String title;
  String hint;
  final AddressData addressData;
  // const LocationForm({super.key});
  FormInput(
      {Key? key,
      required this.title,
      required this.hint,
      required this.addressData})
      : super(key: key);

  void CheckFormInput(String title, final value) {
    if (title == "ชื่อ :") {
      addressData.Address = value;
    }
    // if (title == "ตำแหน่งที่ตั้ง :") {
    //   addressData.point = value;
    // }
    if (title == "รายละเอียดที่อยู่ :") {
      addressData.AddressDetail = value;
    }
    if (title == "จังหวัด :") {
      addressData.Province = value;
    }
    if (title == "เขต :") {
      addressData.District = value;
    }
    if (title == "เบอร์โทรศัพท์ :") {
      addressData.Phonenumber = value;
    }
    if (title == "หมายเหตุ (เพิ่มเติม) :") {
      addressData.Note = value;
    }
  }

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
          child: TextFormField(
            //enabled: false,
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
            onChanged: (value) {
              CheckFormInput(title, value);
            },
          ),
        )
      ],
    );
  }
}
