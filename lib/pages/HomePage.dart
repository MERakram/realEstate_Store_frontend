import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:oued_kniss1/component/ButtomNav.dart';
import 'package:oued_kniss1/component/homePageComponent/categories.dart';
import 'package:oued_kniss1/component/homePageComponent/dropdownbutton.dart';

import '../component/homePageComponent/RecomendedCard.dart';
import '../component/homePageComponent/SmallCard.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(margin: EdgeInsets.only(bottom: 10),
                      height: 30,
                      width: 150,
                      child: dropdownbutton(),
                      // color: Colors.white,
                    ),
                  ],
                ),
              ),
              toolbarHeight: 65,
              collapsedHeight: 65,
              floating: true,
              backgroundColor: const Color(0xFFF1F1F1),
              // backgroundColor: Colors.pink,
              leadingWidth: 70,

              leading: Container(
                child: Icon(
                  Icons.ac_unit,
                  color: Colors.black,
                ),
                margin: EdgeInsets.fromLTRB(20, 3, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
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
              ),
              actions: <Widget>[
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  width: 52,
                  margin: EdgeInsets.fromLTRB(0, 3, 17, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
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
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: [
                      // searchBar(),
                      categories(),
                      RecommendedCard(),
                      SmallCard(),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
        bottomNavigationBar: nav(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
