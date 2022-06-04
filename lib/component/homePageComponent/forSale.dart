import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ForSale extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 3,bottom: 3,right: 5,left:5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xffffe1e1),
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
