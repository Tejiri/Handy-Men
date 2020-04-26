import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handymen/loginpage.dart';
import 'package:handymen/registrationcomplete.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegularUserRegistrationPage extends StatefulWidget {
  @override
  _RegularUserRegistrationPageState createState() =>
      _RegularUserRegistrationPageState();
}

class _RegularUserRegistrationPageState
    extends State<RegularUserRegistrationPage> {
  bool spinner = false;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
 
  var _formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  var myList = [];
  var userList = [];
  

  void emptyList() {
    myList = [];
  }

  void emptyUsernameList() {
    userList = [];
  }

  void check() async {
       if(this.mounted){
    setState(() {
      spinner = true;
    });}
    try {
      await for (var snapshot
          in _firestore.collection("allusers").snapshots()) {
        for (var item in snapshot.documents) {
             if(this.mounted){
          setState(() {
            myList.add(item['email']);
          });}
        }
      }
    } catch (e) {}
  }

  void checkUsername() async {
       if(this.mounted){
    setState(() {
      spinner = true;
    });}
    try {
      await for (var snapshot
          in _firestore.collection("allusers").snapshots()) {
        for (var item in snapshot.documents) {
             if(this.mounted){
          setState(() {
            userList.add(item['username']);
          });}
        }
      }
    } catch (e) {}
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
      // backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          color: Color(hexColor('#26c6da')),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 280,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      // shrinkWrap: true,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(bottom: 50)),
                        CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.person_add,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          "Regular User Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (String value) {
                                 if(this.mounted){
                              setState(() {
                                spinner = false;
                              });}
                              if (value.length == 0) {
                                return "Email field is empty";
                              } else if (!(value.contains("@"))) {
                                return "Email must contain @ symbol";
                              } else if (value[0] == "@") {
                                return "Email cannot begin with @";
                              }
                            },
                            controller: email,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: "Email",
                                labelText: "Email",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            validator: (String value) {
                                 if(this.mounted){
                              setState(() {
                                spinner = false;
                              });}
                              if (value.length == 0) {
                                return "Username field is empty";
                              } else if (value.length > 10) {
                                return "Username cannot bemore than 10 characters";
                              }
                            },
                            controller: username,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Username",
                                labelText: "Username",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length == 0) {
                                return "Firstname field is empty";
                              }
                            },
                            controller: firstname,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Firstname",
                                labelText: "Firstname",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length == 0) {
                                return "Lastname field is empty";
                              }
                            },
                            controller: lastname,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Lastname",
                                labelText: "Lastname",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (String value) {
                              if (value.length == 0) {
                                return "Phone Number field is empty";
                              } else if (value.length != 11) {
                                return "Number must be 11 characters long";
                              }
                            },
                            controller: phonenumber,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: "Phone Number",
                                labelText: "Phone Number",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length == 0) {
                                return "Password field is empty";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                            },
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Password",
                                labelText: "Password",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          // height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          // width: ,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length == 0) {
                                return "Password field is empty";
                              } else if (password.text != password2.text) {
                                return "Password's do not match";
                              }
                            },
                            controller: password2,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Confirm Password",
                                labelText: "Confirm Password",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                       
                    
                        ButtonTheme(
                          minWidth: 150,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            onPressed: () async {
                              check();
                              checkUsername();
                                 if(this.mounted){
                              setState(() {
                                spinner = true;
                              });}
                              if (_formKey.currentState.validate()) {
                               if (myList.contains(email.text)) {
                                
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          title: Text("Email error",
                                              textAlign: TextAlign.center),
                                          children: <Widget>[
                                            Text(
                                              "Email has already been registered",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10)),
                                          ],
                                        );
                                      });
                                         if(this.mounted){
                                  setState(() {
                                    spinner = false;
                                  });}
                                  emptyList();
                                } else if (userList.contains(username.text)) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          title: Text("Username error",
                                              textAlign: TextAlign.center),
                                          children: <Widget>[
                                            Text(
                                              "Username has already been registered",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10)),
                                          ],
                                        );
                                      });
                                         if(this.mounted){
                                  setState(() {
                                    spinner = false;
                                  });}
                                  emptyUsernameList();
                                } else {
                                  try {
                                       if(this.mounted){
                                    setState(() {
                                      spinner = true;
                                    });}
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: email.text,
                                            password: password.text);

                                    

                                    _firestore
                                        .collection("allusers")
                                        .document("${email.text}")
                                        .setData(
                                      {
                                        "email": email.text,
                                        "username": username.text,
                                        "firstname": firstname.text,
                                        "lastname": lastname.text,
                                        "phonenumber": phonenumber.text,
                                        "password": password.text,
                    
                                      },
                                    );

                                    _firestore
                                        .collection(
                                            "unverifiedregularusers")
                                        .document("${email.text}")
                                        .setData(
                                      {
                                        "email": email.text,
                                        "username": username.text,
                                        "firstname": firstname.text,
                                        "lastname": lastname.text,
                                        "phonenumber": phonenumber.text,
                                        "password": password.text,
                                  
                                      },
                                    );
   if(this.mounted){
                                    setState(() {
                                      spinner = false;
                                    });}
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext) {
                                      return RegistrationComplete(
                                          email.text, password.text);
                                    }));
                                  } catch (e) {
                                       if(this.mounted){
                                    setState(() {
                                      spinner = false;
                                    });}
                                    check();
                                    checkUsername();
                                    if (myList.contains(email.text)) {
                                    
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              title: Text("Email error",
                                                  textAlign: TextAlign.center),
                                              children: <Widget>[
                                                Text(
                                                  "Email has already been registered",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10)),
                                              ],
                                            );
                                          });
                                             if(this.mounted){
                                      setState(() {
                                        spinner = false;
                                      });}
                                      emptyList();
                                    } else if (userList
                                        .contains(username.text)) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              title: Text("Username error",
                                                  textAlign: TextAlign.center),
                                              children: <Widget>[
                                                Text(
                                                  "Username has already been registered",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10)),
                                              ],
                                            );
                                          });
                                             if(this.mounted){
                                      setState(() {
                                        spinner = false;
                                      });}
                                      emptyUsernameList();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              children: <Widget>[
                                                Text(
                                                  "Check your internet connection",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10)),
                                                Text(
                                                  "OR",
                                                  textAlign: TextAlign.center,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10)),
                                                Text(
                                                    "email: ${email.text} is badly formatted",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            );
                                          });
                                             if(this.mounted){
                                      setState(() {
                                        spinner = false;
                                      });}
                                    }
                                  }
                                }
                              }
                            },
                            child: Text("Create Account"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        Text("OR",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginPage()));
                              },
                              child: Text(
                                "Sign in",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 60)),
                      ],
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
