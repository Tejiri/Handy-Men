import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handymen/loginpage.dart';
import 'package:handymen/navigation.dart';
import 'package:handymen/registrationtype.dart';
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    method();
  }

  void method() async {
    FirebaseUser user = await _auth.currentUser();
    await Future.delayed(
        Duration(seconds: 3), user != null ? _checkIfLoggedIn : _navi);
  }

  void _checkIfLoggedIn() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigation(1)));
  }

  void _navi() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage("assets/images/logo2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ]),
      ),
    );
  }
}
