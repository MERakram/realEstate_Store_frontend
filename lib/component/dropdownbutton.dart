import 'package:flutter/material.dart';
class dropdownbutton extends StatefulWidget {


  @override
  State<dropdownbutton> createState() => _dropdownbuttonState();
}

class _dropdownbuttonState extends State<dropdownbutton> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      isExpanded: true,

      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      elevation: 16,
      style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
iconSize: 0,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four','el oued','ain temouchent']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(child: Text(value)),
        );
      }).toList(),
    );
  }
}