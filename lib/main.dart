import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.white,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        primaryColor: Purple,
        accentColor: Yellow,
        canvasColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
          size: 16,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          textTheme: TextTheme().copyWith(
            headline6: PurpleHeadingText.copyWith(fontFamily: 'Rubik'),
          ),
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
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: SplashScreen(),
      routes: {
        LoginScreen.routename: (context) => LoginScreen(),
      },
    );
  }
}
