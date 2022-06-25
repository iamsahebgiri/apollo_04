import 'package:flutter/material.dart';

class HeaderForSign extends StatefulWidget {
  //final GlobalKey<ScaffoldState> keys;
  const HeaderForSign({
    Key? key,
    // required this.keys,
  }) : super(key: key);

  @override
  State<HeaderForSign> createState() => _HeaderForSignState();
}

class _HeaderForSignState extends State<HeaderForSign> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      bottom: size.height - 500,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: CustomClipPath(),
        child: Container(
          color: const Color(0xFF3A7DDB),
          // height: 800,
          // width: 600,
          // height: size.height * 0.3,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 10.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size.width / 3.5,
                ),
                const Text(
                  "GHUMO",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: "VarelaRound",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint0 = Paint();
    paint0.color = Colors.red;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.4975000);
    path0.quadraticBezierTo(size.width * 0.0129167, size.height * 0.3781250,
        size.width * 0.0816667, size.height * 0.3750000);
    path0.cubicTo(
        size.width * 0.2902083,
        size.height * 0.3753125,
        size.width * 0.7072917,
        size.height * 0.3759375,
        size.width * 0.9158333,
        size.height * 0.3762500);
    path0.quadraticBezierTo(size.width * 0.9893833, size.height * 0.3800000,
        size.width, size.height * 0.4962500);
    path0.lineTo(size.width, 0);

    // canvas.drawPath(path0, paint0);
    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
