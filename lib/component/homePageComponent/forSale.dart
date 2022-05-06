import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ForSale extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFF6C1BA),
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
            color: Colors.deepOrangeAccent,
          ),
          Text(
            'FOR SALE',
            style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.bold,fontSize: 14),

          ),
        ],
      ),
    );
  }
}
