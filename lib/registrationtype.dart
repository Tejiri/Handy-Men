import 'package:flutter/material.dart';
import 'package:handymen/loginpage.dart';
import 'package:handymen/regularuserregistration.dart';
import 'package:handymen/serviceproviderregistration.dart';
class RegistrationType extends StatefulWidget {
  @override
  _RegistrationTypeState createState() => _RegistrationTypeState();
}

class _RegistrationTypeState extends State<RegistrationType> {

  
  hexColor (String colorhexcode){
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height: double.infinity,
        width: double.infinity,
         color: Color(hexColor('#26c6da')),
        child: Stack(children: <Widget>[        
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Please select your registeration type",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(bottom: 50)),
                ButtonTheme(
                  minWidth: 230,
                  height: 60,
                  buttonColor: Colors.blue,
                  child: Builder(
                    builder: (context) => RaisedButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                   RegularUserRegistrationPage()));
                      },
                      child: Text(
                        "Register as Regular user",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text(
                  "OR",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                ButtonTheme(
                  minWidth: 230,
                  height: 60,
                  buttonColor: Colors.blue,
                  child: Builder(
                    builder: (context) => RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                   ServiceProviderRegistrationPage()));
                      },
                      child: Text(
                        "Register as Service Provider",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
