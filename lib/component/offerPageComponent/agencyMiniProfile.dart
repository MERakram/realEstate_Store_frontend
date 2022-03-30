import 'package:flutter/material.dart';

import '../SmallHouseImage.dart';
class agencyMiniProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 10,
              child: SizedBox(
                child: SmallHouseImage(),
                width: 80,
              ),
            ),
            Flexible(
              flex: 25,
              child: Container(
                width: 300,
                color: Colors.white,
                padding:
                // EdgeInsets.fromLTRB(left, top, right, bottom)
                const EdgeInsets.fromLTRB(10, 1, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'house mda5en in cuoertino',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'house mda5en in cupertino',
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 23,
              ),
              width: 20,
            ),
          ],
        ),
        height: 90,
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF605F5F).withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
