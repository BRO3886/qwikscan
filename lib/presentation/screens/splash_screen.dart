import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../services/utils/shared_prefs_custom.dart';
import '../../utils/themes.dart';
import '../widgets/show_up.dart';
import 'home_screen.dart';
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
    _checkStatus();
  }

  _checkStatus() async {
    final sp = SharedPrefs();
    bool loginStatus = await sp.getLoggedInStatus();
    if (loginStatus == false || loginStatus == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushNamed(LoginScreen.routename);
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushNamed(HomeScreen.routename);
      });
    }
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
