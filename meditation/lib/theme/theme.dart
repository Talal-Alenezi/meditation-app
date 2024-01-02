import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
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

////////////////

//////////////
ThemeData darkMode = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    tabBarTheme: const TabBarTheme(
        dividerColor: Color.fromARGB(255, 122, 128, 133),
        indicatorColor: Color.fromARGB(255, 180, 188, 195),
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 17,
            fontWeight: FontWeight.bold),
        unselectedLabelColor: Color.fromARGB(255, 255, 255, 255)),
    listTileTheme: const ListTileThemeData(
        titleTextStyle:
            TextStyle(color: Color.fromARGB(255, 171, 205, 193), fontSize: 17),
        subtitleTextStyle: TextStyle(
            color: Color.fromARGB(255, 55, 70, 65),
            fontWeight: FontWeight.bold),
        iconColor: Color.fromARGB(255, 0, 0, 0)),
    dialogBackgroundColor: Color.fromARGB(255, 184, 222, 224),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 130, 190, 199)),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)))),
    cardTheme: const CardTheme(color: Color.fromARGB(255, 131, 149, 151)),
    scaffoldBackgroundColor: Color.fromARGB(255, 67, 74, 75),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        backgroundColor: Color.fromARGB(255, 84, 91, 92)),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
      Color.fromARGB(255, 183, 193, 201),
    ))));
