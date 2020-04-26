import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  TextEditingController message = new TextEditingController();
  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  String email;
  String firstname;
  String lastname;
  String location;
  String password;
  String number;
  String servicerating;
  String costrating;
  var rating;
  String name;
  String expertise;
  var userrating = 0.0;

  getUser() async {
    var user = await _auth.currentUser();

    final document = await _firestore.collection("allusers").getDocuments();
    for (var userdetails in document.documents) {
    

      if (user.email.toString() == userdetails['email']) {
           if(this.mounted){
        setState(() {
          email = userdetails['email'];
          firstname = userdetails['firstname'];
          lastname = userdetails['lastname'];
          location = userdetails['location'];
          password = userdetails['password'];
          number = userdetails['phonenumber'];
          servicerating = userdetails['servicerating'];
          costrating = userdetails['costrating'];
          expertise = userdetails['specialization'];
          name = userdetails['username'];
        });}
      }
    }
  }

  body() {
    return ListView(
      children: <Widget>[
        Container(
            //  color: Colors.blue,
            child: Container(
          height: 310,
          width: double.infinity,
          color: Colors.blueAccent.withOpacity(0.6),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image(
                  image: AssetImage("assets/images/5.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 25)),
                    CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 35,
                      ),
                      backgroundColor: Colors.blueAccent.withOpacity(0.6),
                      radius: 55,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    name == null
                        ? Center(child: CircularProgressIndicator())
                        : Text(
                            "$name",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    servicerating == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Overall Rating:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SmoothStarRating(
                                borderColor: Colors.black,
                                starCount: 5,
                                rating: (double.parse(servicerating) +
                                        double.parse(costrating)) /
                                    2,
                                size: 20,
                                color: Colors.black,
                                spacing: 0.0,
                              ),
                            ],
                          ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    servicerating == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Service Rating:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SmoothStarRating(
                                borderColor: Colors.black,
                                starCount: 5,
                                rating: double.parse(servicerating),
                                size: 20,
                                color: Colors.black,
                                spacing: 0.0,
                              ),
                            ],
                          ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    servicerating == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Cost Rating:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SmoothStarRating(
                                borderColor: Colors.black,
                                starCount: 5,
                                rating: double.parse(costrating),
                                size: 20,
                                color: Colors.black,
                                spacing: 0.0,
                              ),
                            ],
                          ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                ),
              )
            ],
          ),
        )),
        name == null
            ? Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 70)),
                  Center(child: CircularProgressIndicator())
                ],
              )
            : Column(
                children: <Widget>[
                  email == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.7),
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$email (Email)"),
                              
                            ),
                          ),
                        ),
                  firstname == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.6),
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                             
                              title: Text("$firstname (Firstname)"),
                            ),
                          ),
                        ),
                  lastname == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.5),
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$lastname (Lastname)"),
                            ),
                          ),
                        ),
                  location == null
                      ? Container()
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.4),
                          child: Center(
                            child: ListTile(
                             leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$location (Location)"),
                            ),
                          ),
                        ),
                  password == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.3),
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$password (Password)"),
                            ),
                          ),
                        ),
                  number == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.2),
                          child: Center(
                            child: ListTile(
                            leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$number (Phone Number)"),
                            ),
                          ),
                        ),
                  expertise == null
                      ? Container()
                      : Container(
                          color: Colors.blueAccent.withOpacity(0.1),
                          child: Center(
                            child: ListTile(
                             leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$expertise (Specialization)"),
                            ),
                          ),
                        ),
                  name == null
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          color: Colors.blueAccent.withOpacity(0),
                          child: Center(
                            child: ListTile(
                             leading: Icon(Icons.person,color: Colors.black.withOpacity(0.5),),
                              title: Text("$name (Username)"),
                            ),
                          ),
                        )
                ],
              )
      ],
    );
  }

  void allRatings() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //    backgroundColor: Colors.blueAccent,
        body: body());
  }
}
