import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qwickscan/presentation/widgets/show_up.dart';

import '../../utils/themes.dart';
import 'login_screen.dart';

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
      Navigator.of(context).pushNamed(LoginScreen.routename);
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
              ShowUp(
                delay: Duration(milliseconds: 300),
                child: Lottie.asset(
                  'assets/animations/shopping-lady.json',
                  height: 100,
                  repeat: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ShowUp(
                child: Text(
                  'QwickScan',
                  style: PurpleHeadingText,
                ),
                delay: Duration(milliseconds: 500),
              ),
              ShowUp(
                delay: Duration(milliseconds: 700),
                child: Text(
                  'WE MAKE SHOPPING EASY',
                  style: SmallGreyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
