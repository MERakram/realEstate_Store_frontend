import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ForRent extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 3,bottom: 3,right: 5,left:5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFBAF6F1),
        shape: BoxShape.rectangle,
      ),
      // alignment: Align(),
      width: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            LineIcons.search,
            size: 20,
            color: Color(0xFF25A985),
          ),
          Text(
            'FOR RENT',
            style: TextStyle(
                color: Color(0xFF25A985),
                fontWeight: FontWeight.bold,fontSize: 14),

          ),
        ],
      ),
    );
  }
}
