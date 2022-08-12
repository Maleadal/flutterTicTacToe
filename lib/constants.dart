import 'package:flutter/material.dart';

int playerX = 0;
int playerO = 0;
double fontSize = 25;
double appBarHeight = 50;
List<String> grid = List.generate(9, (index) => ' ', growable: false);

TextStyle textStyle = TextStyle(
  color: Colors.white,
  fontSize: fontSize,
  fontWeight: FontWeight.bold,
);