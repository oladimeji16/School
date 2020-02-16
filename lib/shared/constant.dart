import 'package:flutter/material.dart';
import '../days_of_the_week.dart';

const textInputDecoration = InputDecoration(
    focusColor: boxColor,
    hintStyle:
    TextStyle(
      color: grayColor,
    ),
    fillColor: boxColor,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textColor, width: 2.0,),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textColor, width: 2.0,),
    ),
  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0)
);

