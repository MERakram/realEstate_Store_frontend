import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oued_kniss1/component/forRent.dart';

import 'BigHouseImage.dart';

class RecommendedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return Container(
      height: height * 0.51,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: null),
          shrinkWrap: true,
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(12, 1, 12, 5),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(7),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    BigHouseImage(),
                    Padding(
                      padding:
                          // EdgeInsets.fromLTRB(left, top, right, bottom)
                          const EdgeInsets.fromLTRB(18, 1, 12, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ForRent(),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            'house mda5en in cupirtino ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          const Text(
                            'house mda5en in cupirtino hello wo ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$ 120.00 / day',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF605F5F).withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: 300,
              ),
            );
          }),
    );
  }
}
