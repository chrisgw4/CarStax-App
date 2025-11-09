import "package:car_stax/main.dart";
import "package:flutter/material.dart";

ThemeData dark_mode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    tertiary: "#48B89F".toColor(),
    inversePrimary: Colors.grey.shade300,
    inverseSurface: Colors.white
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.black,
  ),
    hintColor: Colors.grey.shade500
);