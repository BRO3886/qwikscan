import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qwickscan/presentation/screens/home_screen.dart';
import 'package:qwickscan/utils/themes.dart';

class SplashScreen extends StatefulWidget {
  static const routename = "/";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(HomeScreen.routename);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                'assets/animations/shopping-lady.json',
                height: 100,
                repeat: true,
              ),
              SizedBox(
                height: 20,
              ),
              Hero(
                tag: 'lottie-to-text',
                child: Text(
                  'QwickScan',
                  style: PurpleHeadingText,
                ),
              ),
              Text(
                'WE MAKE SHOPPING EASY',
                style: SmallGreyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
