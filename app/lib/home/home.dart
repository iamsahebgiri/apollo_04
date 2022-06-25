import 'package:flutter/material.dart';
import 'package:ghumo/global/global.dart';
import 'package:ghumo/splash/splash.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text("GHUMO"),
        actions: [
          IconButton(
            onPressed: () async {
              await sharedPreferences!.setBool("user", false);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
