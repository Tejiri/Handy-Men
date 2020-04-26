import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handymen/registrationtype.dart';
import 'package:handymen/homepage.dart';
import 'package:handymen/navigation.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  var _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var currentitem;

  @override
  void initState() { 
    super.initState();
 
  }

  

  hexColor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(hexColor('#26c6da')),

              /*  child: Image(image: AssetImage("assets/images/4.jpg"),fit: BoxFit.cover,),*/
            ),
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/icon2.png"),
                        width: 200,
                        height: 150,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30)),
                      Text(
                        "Welcome to Seefin",
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 50)),
                      Theme(
                        data: ThemeData(
                          hintColor: Colors.white,
                          primaryColor: Colors.white,
                        ),
                        child: Container(
                          width: 250,
                          child: TextField(
                            controller: email,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              labelText: "Email",
                              hintText: 'Enter Email',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              suffixStyle: TextStyle(color: Colors.yellow),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30)),
                      Theme(
                        data: ThemeData(
                          hintColor: Colors.white,
                          primaryColor: Colors.white,
                        ),
                        child: Container(
                          width: 250,
                          child: TextField(
                            obscureText: true,
                            controller: password,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              labelText: "Password",
                              hintText: 'Enter Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffixStyle: TextStyle(color: Colors.yellow),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      ButtonTheme(
                        minWidth: 150,
                        height: 50,
                        buttonColor: Colors.blue,
                        child: Builder(
                          builder: (context) => RaisedButton(
                            onPressed: () async {
                                 if(this.mounted){
                              setState(() {
                                spinner = true;
                              });}
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                FirebaseUser user2 = await _auth.currentUser();
                                if (user != null) {
                                  if (user2.isEmailVerified) {
                                    List verifiedemails = [];
                                    final doc = await _firestore
                                        .collection("alluser")
                                        .getDocuments();
                                    final doc2 = await _firestore
                                        .collection(
                                            "unverifiedserviceproviders")
                                        .getDocuments();
                                    final doc3 = await _firestore
                                        .collection("unverifiedregularusers")
                                        .getDocuments();
                                    for (var item in doc2.documents) {
                                      if (item['email'] == email.text) {
                                        var myemail = item['email'];
                                        var myusername = item['username'];
                                        var myfirstname = item['firstname'];
                                        var mylastname = item['lastname'];
                                        var mynumber = item['phonenumber'];
                                        var myservicerating =
                                            item['servicerating'];
                                        var mycostrating = item['costrating'];
                                        var mypassword = item['password'];
                                        var myspecialization =
                                            item['specialization'];
                                        var mylocation = item['location'];

                                        _firestore
                                            .collection(
                                                "verifiedserviceproviders")
                                            .document("$mylocation")
                                            .collection("$myspecialization")
                                            .document("$myemail")
                                            .setData(
                                          {
                                            "email": myemail,
                                            "username": myusername,
                                            "firstname": myfirstname,
                                            "lastname": mylastname,
                                            "phonenumber": mynumber,
                                            "password": mypassword,
                                            "specialization": myspecialization,
                                            "location": mylocation,
                                            "servicerating": myservicerating,
                                            "costrating": mycostrating
                                          },
                                        );

                                        _firestore
                                            .collection(
                                                "allverifiedserviceproviders")
                                            .document("${email.text}")
                                            .setData(
                                          {
                                            "email": myemail,
                                            "username": myusername,
                                            "firstname": myfirstname,
                                            "lastname": mylastname,
                                            "phonenumber": mynumber,
                                            "password": mypassword,
                                            "specialization": myspecialization,
                                            "location": mylocation,
                                            "servicerating": myservicerating,
                                            "costrating": mycostrating
                                          },
                                        );

                                        _firestore
                                            .collection(
                                                "unverifiedserviceproviders")
                                            .document("$myemail")
                                            .delete();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BottomNavigation(1)));
                                      }
                                    }

                                    for (var item in doc3.documents) {
                                      if (item['email'] == email.text) {
                                        var myemail = item['email'];
                                        var myusername = item['username'];
                                        var myfirstname = item['firstname'];
                                        var mylastname = item['lastname'];
                                        var mynumber = item['phonenumber'];

                                        var mypassword = item['password'];

                                        _firestore
                                            .collection("allverifiedregularusers")
                                            .document("$myemail")
                                            .setData(
                                          {
                                            "email": myemail,
                                            "username": myusername,
                                            "firstname": myfirstname,
                                            "lastname": mylastname,
                                            "phonenumber": mynumber,
                                            "password": mypassword,
                                          },
                                        );

                                        _firestore
                                            .collection(
                                                "unverifiedregularusers")
                                            .document("$myemail")
                                            .delete();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BottomNavigation(1)));
                                      }
                                    }

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BottomNavigation(1)));
                                  } else {
                                    user2.sendEmailVerification();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            SimpleDialog(
                                              title: Text(
                                                "Email verification",
                                                textAlign: TextAlign.center,
                                              ),
                                              children: <Widget>[
                                                Text(
                                                    "Your email is not yet verified. You will receive an email shortly Follow the link to verify",
                                                    textAlign:
                                                        TextAlign.center),
                                              ],
                                            ));
                                  }
                                }
   if(this.mounted){
                                setState(() {
                                  spinner = false;
                                });}
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Login failed, please check details entered or Internet connection",
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(seconds: 4),
                                ));
   if(this.mounted){
                                setState(() {
                                  spinner = false;
                                });}
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      GestureDetector(
                          child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.red),
                      )),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RegistrationType())),
        label: Text("Register"),
        icon: Icon(Icons.person),
      ),
    );
  }
}
//