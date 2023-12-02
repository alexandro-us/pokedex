import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {

  // Light theme
  // static Color lightBackgroundColor = Colors.white.withOpacity(0.9);
  static Color lightBackgroundColor = const Color(0xFFFFFFFF);
  static Color lightPrimaryColor = const Color(0xFFDC0A2D);
  static Color lightSecundaryColor = const Color.fromARGB(255, 237, 200, 137);
  static Color darkBackgroundColor = const Color.fromARGB(255, 38, 38, 39);
  static Color darkContentColor = const Color.fromARGB(255, 31, 31, 31);


  static double sizeTitle = 32;
  static double sizeSubtitle = 26;
  static double textSize = 22;

  static TextStyle titleAppBar = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle normalText = const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black);

  static List<BoxShadow> boxShadow = const <BoxShadow>[
    BoxShadow(
      color: Color.fromARGB(30, 0, 0, 0),
      offset: Offset(0, 3),
      blurRadius: 4
    )
  ];

  static SystemUiOverlayStyle systemUiOverlayStyleLight = const SystemUiOverlayStyle(
      statusBarColor: Colors.white, 
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark, // For iOS (dark icons)
    );

  static SystemUiOverlayStyle systemUiOverlayStyleDark = const SystemUiOverlayStyle(
    statusBarColor: Colors.black, 
    statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    statusBarBrightness: Brightness.light, // For iOS (dark icons)
  );

  static ThemeData appThemeLight = ThemeData.light().copyWith(
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: lightBackgroundColor,
      cursorColor: AppTheme.lightPrimaryColor,
    ),
    backgroundColor: lightBackgroundColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(  
      backgroundColor: lightPrimaryColor
    ),
    iconTheme: IconThemeData(  
      color: lightBackgroundColor
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimaryColor,
      systemOverlayStyle: systemUiOverlayStyleLight,
      iconTheme: const IconThemeData(  
        color: Colors.black54,
      ),
      titleTextStyle: const TextStyle(color: Colors.black54),
      elevation: 1.0
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black54)),

    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }
    )
  );
  static ThemeData appThemeDark = ThemeData.dark().copyWith(
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: darkBackgroundColor,
      cursorColor: AppTheme.lightPrimaryColor,
    ),
    backgroundColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(  
      backgroundColor: lightPrimaryColor
    ),
    iconTheme: IconThemeData(  
      color: lightPrimaryColor
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: systemUiOverlayStyleDark,
      iconTheme: const IconThemeData(  
        color: Colors.white70,
      ),
      titleTextStyle: const TextStyle(color: Colors.white70),
      elevation: 1.0
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white70)),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }
    )
  );

}