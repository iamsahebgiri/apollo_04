import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:ghumo/home/home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> pages = [
      {
        'image': 'assets/images/a.png',
      },
      {
        'image': 'assets/images/b.png',
      },
      {
        'image': 'assets/images/c.png',
      },
    ];
    return Scaffold(
      body: ConcentricPageView(
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage1(),
            ),
          );
        },
        itemBuilder: (index) {
          int pageIndex = (index % pages.length);
          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  pages[pageIndex]['image'],
                ),
              ],
            ),
          );
        },
        colors: const [
          Colors.white,
          Colors.blue,
          Colors.greenAccent,
        ],
      ),
    );
  }
}
