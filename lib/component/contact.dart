import 'package:flutter/material.dart';

class contact extends StatelessWidget {
  String img;
  String title;

  contact(this.img, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            img,
            height: 44,
            width: 44,
          ),
          SizedBox(
            width: 30,
          ),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
