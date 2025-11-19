import 'package:flutter/material.dart';

const _ink = Color(0xFF0D0D0D);
const _purple = Color(0xFF6A0DAD);
const _indigo = Color(0xFF4B0082);

final ThemeData ravenDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: _ink,
  
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Colors.black,
  //   centerTitle: true,
  //   titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  // ),
  // // colorScheme: const ColorScheme.dark(primary: _purple, secondary: _indigo),
  // textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
);
