import 'package:flutter/material.dart';

class categories extends StatefulWidget {
  late final ValueChanged<bool> onSelected;
  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  bool _isSelected=false;
  int selectedIndex=0;


  final List<String> _list = [
    'appartement',
    'house',
    'industrial',
    'commercial',
    'land'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        height: 70,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(12, 0, 20, 0),
          physics: const BouncingScrollPhysics(parent: null),
          shrinkWrap: true,
          itemCount: _list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  // _isSelected = !_isSelected;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Center(
                    child: Text(
                      _list[index],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                    // border: _isSelected?Border.all(color: Color(0xFFCDB889)):null,
                    borderRadius: BorderRadius.circular(13.0),
                    color: selectedIndex == index ? Color(0xFFE5D6A7):Color(0xFFFFFFFF),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF605F5F).withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(2, 1),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
