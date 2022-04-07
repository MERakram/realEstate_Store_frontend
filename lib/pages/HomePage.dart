import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/homePageComponent/categories.dart';
import 'package:oued_kniss1/component/homePageComponent/dropdownbutton.dart';
import '../component/homePageComponent/RecomendedCard.dart';
import '../component/homePageComponent/SmallCard.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(margin: const EdgeInsets.only(bottom: 10),
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
                child: const Icon(
                  Icons.ac_unit,
                  color: Colors.black,
                ),
                margin: const EdgeInsets.fromLTRB(20, 3, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF605F5F).withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  child: const Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  width: 52,
                  margin: const EdgeInsets.fromLTRB(0, 3, 17, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF605F5F).withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
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
        // bottomNavigationBar: nav(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
