import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/snackBar.dart';

import 'FilterSheet.dart';

class searchBar extends StatefulWidget {
  @override
  _searchBarState createState() {
    return _searchBarState();
  }
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 10, 20),
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF605F5F).withOpacity(0.1),
                spreadRadius: -2,
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isDismissible: true,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => FilterOffer(context: context),
            );
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            width: 65,
            height: 60,
            child: Icon(
              Icons.search,
              size: 40,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF605F5F).withOpacity(0.1),
                  spreadRadius: -2,
                  blurRadius: 6,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
