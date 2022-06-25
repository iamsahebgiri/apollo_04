import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghumo/global/global.dart';
import 'package:ghumo/home/home.dart';
import 'package:ghumo/register/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer() {
    Timer(const Duration(seconds: 2), () {
      if (sharedPreferences!.getBool("user") == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const MainHome()),
          ),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const LogInCumSignupSCreen()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("GHUMO"),
            Text("Travel with Passion"),
            SizedBox(
              height: 50.0,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
