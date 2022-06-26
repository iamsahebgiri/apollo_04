import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghumo/wallet/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GHUMO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wallet(),
        // const Details(
        //   imgUrl:
        //       "https://images.unsplash.com/photo-1583212348415-4ca550b3521a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80",
        //   placeName: "Puri",
        //   rating: 5.0,
        // ),
        );
  }
}
