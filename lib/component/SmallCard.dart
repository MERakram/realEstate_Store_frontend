import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oued_kniss1/component/forRent.dart';

import 'SmallHouseImage.dart';

class SmallCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: null),
      shrinkWrap: true,
      itemCount: 10,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 07, 10, 7),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(flex: 10,
                  child: SizedBox(
                    child: SmallHouseImage(),
                    width: 130,
                  ),
                ),
                Flexible(flex:16 ,
                  child: Container(color: Colors.white,
                    padding:
                        // EdgeInsets.fromLTRB(left, top, right, bottom)
                        const EdgeInsets.fromLTRB(10, 1, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ForRent(),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'house mda5en in cuoertino',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'house mda5en in cupertino h',
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 13,
                                child: Icon(Icons.add),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'FO',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 13,
                                child: Icon(Icons.add),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'FO',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 13,
                                child: Icon(Icons.add),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'FO',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          '\$ 120.00 / day',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            height: height * 0.22,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
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
      },
    );
  }
}
