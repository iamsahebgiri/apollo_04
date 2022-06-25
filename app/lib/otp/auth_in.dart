import 'package:flutter/material.dart';

import 'anon_body.dart';
import 'anon_head.dart';

class AnonSignIn extends StatefulWidget {
  final String phone;
  const AnonSignIn({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<AnonSignIn> createState() => _AnonSignInState();
}

class _AnonSignInState extends State<AnonSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AnonHeaderOTPScreenOld(),
          AnonBodyOTp(
            phoneNumber: widget.phone,
          ),
        ],
      ),
    );
  }
}
