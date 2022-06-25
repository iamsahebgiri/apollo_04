import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String label;
  final IconData? iconData;
  final String? hintText;
  bool isobsure;
  bool? isenable;
  final TextInputType? keytype;
  CustomTextField({
    Key? key,
    this.textEditingController,
    required this.label,
    this.iconData,
    this.hintText,
    required this.isobsure,
    this.isenable,
    this.keytype,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      child: TextFormField(
        controller: textEditingController,
        enabled: isenable,
        keyboardType: keytype,
        obscureText: isobsure,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(label),
        ),
      ),
    );
  }
}
