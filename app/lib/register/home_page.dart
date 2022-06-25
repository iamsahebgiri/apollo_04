import 'package:flutter/material.dart';
import 'buid_body_sign.dart';
import 'header_sign_in.dart';

class LogInCumSignupSCreen extends StatelessWidget {
  const LogInCumSignupSCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: const [
          HeaderForSign(),
          BuildBodySignIn(),
        ],
      ),
    );
  }
}
