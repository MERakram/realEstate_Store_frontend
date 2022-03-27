import 'package:flutter/material.dart';

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
          margin: const EdgeInsets.fromLTRB(20, 10, 10, 0),
          width: 310,
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
                color: Color(0xFF605F5F).withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        Container(
          child: const Icon(
            Icons.location_on,
          ),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
    );
  }
}
