import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghumo/home/home.dart';
import 'package:http/http.dart' as https;

import 'package:ghumo/global/loading_dialog.dart';
import 'package:ghumo/reuster_new_user/custome_text.dart';

import '../global/error_dialog.dart';
import '../global/global.dart';

class RegisterNewUser extends StatefulWidget {
  final String phone;
  const RegisterNewUser({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<RegisterNewUser> createState() => _RegisterNewUserState();
}

class _RegisterNewUserState extends State<RegisterNewUser> {
  void validate() async {
    if (name.text.isNotEmpty && email.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog(
              message: "",
            );
          });
      authenticate();
    } else {
      print("in error");
      showDialog(
        context: context,
        builder: (context) {
          return const ErrorDialog(
            message: "Fill all",
          );
        },
      );
    }
  }

  void saveDataLocally(dynamic jsonresult) async {
    String id = jsonresult["userData"]["_id"];
    String name = jsonresult["userData"]["name"];
    String email = jsonresult["userData"]["email"];
    String phone = jsonresult["userData"]["phone"];
    String avatar = jsonresult["userData"]["avatar"];
    String userType = jsonresult["userData"]["userType"];
    String bio = jsonresult["userData"]["bio"];
    bool emailVerified = jsonresult["userData"]["phoneVerified"];
    await sharedPreferences!.setString(id, jsonresult["userData"]["_id"]);
    await sharedPreferences!.setString(name, jsonresult["userData"]["name"]);
    await sharedPreferences!.setString(email, jsonresult["userData"]["email"]);
    await sharedPreferences!.setString(phone, jsonresult["userData"]["phone"]);
    await sharedPreferences!.setString(avatar, jsonresult["userData"]["avatar"]);
    await sharedPreferences!
        .setString(userType, jsonresult["userData"]["userType"]);
    await sharedPreferences!.setString(bio, jsonresult["userData"]["bio"]);
    await sharedPreferences!.setBool("user", true);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainHome()));
  }

  void authenticate() async {
    print("in auth");

    var fl = name.text.substring(0, 1).toUpperCase();
    var ll = name.text.split(" ")[1].substring(0, 1).toLowerCase();
    var ff = fl + ll;
    var vres = {
      'name': name.text,
      'email': email.text,
      'bio': bio.text,
      'phone': widget.phone,
      'avatar': 'https://avatar.tovi.sh/tobiaslins.svg?text=$ff'
    };
    //  print(vres);
    var result = await https.post(
      Uri.parse("https://ghumo-server.herokuapp.com/api/user/register/"),
      body: vres,
    );
    var jsonresult = jsonDecode(result.body);
    print(jsonresult);
    saveDataLocally(jsonresult);
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController bio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100.0,
            ),
            CustomTextField(
              textEditingController: name,
              isobsure: false,
              label: "Full Name*",
            ),
            CustomTextField(
              textEditingController: email,
              isobsure: false,
              label: "Email*",
            ),
            CustomTextField(
              textEditingController: bio,
              isobsure: false,
              label: "Bio",
            ),
            ElevatedButton(
              onPressed: () {
                validate();
              },
              child: const Text("Authorize"),
            ),
          ],
        ),
      ),
    );
  }
}
