import 'package:flutter/material.dart';



class SmallHouseImage2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 290,
      height: 290,
      child: Container(
        padding:
        const EdgeInsets.fromLTRB(6, 5, 5, 6), // Border width
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox.fromSize(
            size: const Size.fromRadius(
                50), // Image radius
            child: Image.asset('assets/images/vanta.jpg',
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
