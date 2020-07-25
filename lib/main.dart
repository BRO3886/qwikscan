import 'package:flutter/material.dart';
import 'package:qwickscan/utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik',
        primaryColor: Purple,
        accentColor: Yellow,
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
          size: 16,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: borderRadius8,
            borderSide: BorderSide.none,
          ),
          fillColor: Grey,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Rubik',
          ),
        ),
      ),
    );
  }
}
