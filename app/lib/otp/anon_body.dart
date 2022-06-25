import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghumo/home/home.dart';
import 'package:ghumo/reuster_new_user/register_new_user.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../global/global.dart';
import '../global/loading_dialog.dart';
import 'package:http/http.dart' as https;

class AnonBodyOTp extends StatefulWidget {
  final String phoneNumber;
  const AnonBodyOTp({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<AnonBodyOTp> createState() => _AnonBodyOTpState();
}

class _AnonBodyOTpState extends State<AnonBodyOTp> {
  TextEditingController otpController1 = TextEditingController();
  String verificationId = "";
  String smsCode = "";
  //AuthClass authClass = AuthClass();
  bool issend = false;
  int start = 30;
  void setTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          issend = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void validate() async {
    if (otpController1.text.isNotEmpty && otpController1.text.length == 6) {
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog(
              message: "",
            );
          });
      await authenticate1();
    }
  }

  void fetchData(dynamic response) async {
    String id = response["userData"]["_id"];
    String name = response["userData"]["name"];
    String email = response["userData"]["email"];
    String phone = response["userData"]["phone"];
    String avatar = response["userData"]["avatar"];
    String userType = response["userData"]["userType"];
    String bio = response["userData"]["bio"];
    bool emailVerified = response["userData"]["emailVerified"];
    bool phoneVerified = response["userData"]["phoneVerified"];
    await sharedPreferences!.setString(id, response["userData"]["_id"]);
    await sharedPreferences!.setString(name, response["userData"]["name"]);
    await sharedPreferences!.setString(email, response["userData"]["email"]);
    await sharedPreferences!.setString(phone, response["userData"]["phone"]);
    await sharedPreferences!.setString(avatar, response["userData"]["avatar"]);
    await sharedPreferences!
        .setString(userType, response["userData"]["userType"]);
    await sharedPreferences!.setString(bio, response["userData"]["bio"]);
    Navigator.pop(context);
    await sharedPreferences!.setBool("user", true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainHome()));
  }

  Future<void> authenticate1() async {
    UserCredential userCredential = await authClass.signInWithPhoneNumber(
      verificationId,
      smsCode,
      context,
      widget.phoneNumber,
    );
    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      var res = await https.get(Uri.parse(
          "https://ghumo-server.herokuapp.com/api/user/exists/${widget.phoneNumber}"));
      //print(res.body);
      var decodeJson = jsonDecode(res.body);
      print(decodeJson);
      if (decodeJson["res"] == true) {
        //TODOS: USER ALREADY REGISTERED
        //TODOS: FETCH DATA FROM DB AND SAVE TO SHAREDPREF
        //Fetch Data  and then
        fetchData(decodeJson);
        print("True res");
      } else if (decodeJson["res"] == false) {
        //TODOS: USER NOT REGISTERED
        //TODOS: PosT DATA FROM DB AND SAVE TO SHAREDPREF

        print("Register this user");
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterNewUser(
                      phone: widget.phoneNumber,
                    )));
      }
      // ignore: avoid_print
      print("saving data locally");
      showSnackBar(context, "Correct OTP");
      //getDataAndSaveLocally();
      setState(() {
        start = 0;
      });
    } else {
      Navigator.pop(context);
      showSnackBar(context, "Wrong OTP entered");
    }
  }

  void setData(String verificationsId) {
    setState(() {
      verificationId = verificationsId;
    });
    setTimer();
  }

  @override
  void initState() {
    // setTimer();
    super.initState();

    //TODOS:1
    authClass.verifyPhoneNumber(
      "+91 ${widget.phoneNumber}",
      context,
      setData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.2,
      bottom: 0,
      left: size.width * 0.0002,
      right: size.width * 0.0002,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // color: Colors.red,
        body: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/otp.png"),
              const Center(
                child: Text(
                  "Type Your OTP",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "VarelaRound",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "OTP has been sent to your registered mobile number",
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12.0,
                    fontFamily: "VarelaRound",
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text(
                  "******${widget.phoneNumber.substring(6)}",
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              // TextField(
              //   controller: otpController1,
              // ),
              OTPTextField(
                // controller: otpController1,
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed Pin$pin");
                  setState(() {
                    smsCode = pin;
                    otpController1.text = pin;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            issend
                                ? {
                                    //resend otp
                                    authClass.signInWithPhoneNumber(
                                      verificationId,
                                      smsCode,
                                      context,
                                      // widget.userName,
                                      widget.phoneNumber,
                                    ),
                                    // ignore: avoid_print
                                    print("resend otp"),
                                    start = 30,
                                    issend = false,
                                    setTimer(),
                                  }
                                : {
                                    const SnackBar(
                                      content: Text("Please wait until timer"),
                                    ),
                                    // ignore: avoid_print
                                    print("Please wait until timer"),
                                  };
                          },
                        text: "Resend OTP in",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: issend ? Colors.blue : Colors.grey,
                        ),
                      ),
                      const TextSpan(
                        text: "in",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "00:$start",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.pink,
                        ),
                      ),
                      const TextSpan(
                        text: " sec",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  //validateform1();
                  validate();
                },
                child: SizedBox(
                  height: size.height * 0.06,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
