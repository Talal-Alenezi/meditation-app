import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    tabBarTheme: const TabBarTheme(
        indicatorColor: Color.fromARGB(255, 122, 128, 133),
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 122, 128, 133),
            fontSize: 17,
            fontWeight: FontWeight.bold),
        unselectedLabelColor: Color.fromARGB(255, 122, 128, 133)),
    listTileTheme: const ListTileThemeData(
        titleTextStyle:
            TextStyle(color: Color.fromARGB(255, 65, 107, 94), fontSize: 17),
        subtitleTextStyle: TextStyle(
            color: Color.fromARGB(255, 91, 113, 106),
            fontWeight: FontWeight.bold),
        iconColor: Color.fromARGB(255, 122, 128, 133)),
    dialogBackgroundColor: const Color.fromARGB(255, 211, 251, 255),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 141, 190, 255)),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 122, 128, 133)))),
    cardTheme: const CardTheme(color: Color.fromARGB(255, 211, 251, 255)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 229, 251, 255),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 122, 128, 133),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        backgroundColor: Color.fromARGB(255, 229, 251, 255)),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
      Color.fromARGB(255, 214, 231, 243),
    ))));
