import 'package:flutter/material.dart';
import 'package:handymen/loginpage.dart';
import 'package:handymen/main.dart';

class RegistrationComplete extends StatefulWidget {
  String email;
  String password;
  RegistrationComplete(this.email, this.password);
  @override
  _RegistrationCompleteState createState() =>
      _RegistrationCompleteState(this.email, this.password);
}

class _RegistrationCompleteState extends State<RegistrationComplete> {
  String email;
  String password;
  _RegistrationCompleteState(this.email, this.password);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    });
  }

  hexColor (String colorhexcode){
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(hexColor('#26c6da')),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You are now fully registered",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                "Please enter details to login",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                "email: $email",
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Text(
                "password: $password",
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              CircularProgressIndicator(
                backgroundColor: Colors.red,
                //  strokeWidth: 5.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
