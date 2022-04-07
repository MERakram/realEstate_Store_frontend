import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ForRent extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFBAF6F1),
        shape: BoxShape.rectangle,
      ),
      // alignment: Align(),
      width: 100,
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
