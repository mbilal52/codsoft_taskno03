import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChange(val)){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8)
    ),
    child: DropdownButton<String>(
      value: null,
      onChanged: (String? val){
        onChange(val);
      },
      items: items.map<DropdownMenuItem<String>> ((String val) {
        return DropdownMenuItem(
          child: Text(val),
          value: val,
          );
      }).toList(),
    ),
  );
}