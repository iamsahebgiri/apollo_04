import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghumo/global/global.dart';
import 'package:ghumo/home/main_home.dart';
import 'package:ghumo/splash/splash_home.dart';

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
            builder: ((context) => const MainHomePage()),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const HomePage()),
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
            Text(
              "GHUMO",
              style: TextStyle(
                fontSize: 50.0,
                fontFamily: "Lobster",
              ),
            ),
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
