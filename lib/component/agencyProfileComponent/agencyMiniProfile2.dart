import 'package:flutter/material.dart';

import '../SmallHouseImage.dart';

class agencyMiniProfile2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Container(
        // color: Colors.pink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 11,
              child: SizedBox(
                child: SmallHouseImage(),
                width: 100,
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
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'house mda5en in cuoertino',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
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
          ],
        ),
        height: 120,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      ),
    );
  }
}
