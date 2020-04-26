import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handymen/chatscreen.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class HandyManProfile extends StatefulWidget {
  
  var loggedinuserfirstname;
  var loggedinuserlastname;

   var loggedinuserphonenumber;
  var loggedinuseremail;
var loggedinuserusername;
  String email;
  String firstname;
  String lastname;
  String location;
  String password;
  String name;
  String number;
  String expertise;
  String servicerating;
  String costrating;
  HandyManProfile(
      this.loggedinuserfirstname,
   this.loggedinuserlastname,
    this.loggedinuserphonenumber,
     this.loggedinuseremail,
    this.loggedinuserusername,
      this.email,
      this.firstname,
      this.lastname,
      this.location,
      this.password,
      this.name,
      this.number,
      this.expertise,
      this.servicerating,
      this.costrating);
  @override
  _HandyManProfileState createState() => _HandyManProfileState(
      loggedinuserfirstname,
   loggedinuserlastname,

  loggedinuserphonenumber,
    loggedinuseremail,
    loggedinuserusername,
      email,
      firstname,
      lastname,
      location,
      password,
      name,
      number,
      expertise,
      servicerating,
      costrating);
}

class _HandyManProfileState extends State<HandyManProfile> {
  TextEditingController message = new TextEditingController();
  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
   var loggedinuserfirstname;
  var loggedinuserlastname;

   var loggedinuserphonenumber;
var loggedinuseremail;
var loggedinuserusername;
  String email;
  String firstname;
  String lastname;
  String location;
  String password;
  String name;
  String number;
  String expertise;
  String servicerating;
  String costrating;
  var userservicerating = 0.0;
  var usercostrating = 0.0;
  _HandyManProfileState(
     this.loggedinuserfirstname,
  this.loggedinuserlastname,

   this.loggedinuserphonenumber,
    this.loggedinuseremail,
    this.loggedinuserusername,
      this.email,
      this.firstname,
      this.lastname,
      this.location,
      this.password,
      this.name,
      this.number,
      this.expertise,
      this.servicerating,
      this.costrating);

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    var useremail = user.email.toString();
    loggedinuseremail = useremail;

    var document = await _firestore.collection("allusers").document("$loggedinuseremail").get();
    loggedinuserusername= document['username'];
  

  }

  void share(
    BuildContext context,
  ) {
    final RenderBox box = context.findRenderObject();

    Share.share(
        "Hello, \n\n$loggedinuserfirstname $loggedinuserlastname shared service provider $firstname $lastname ($expertise) - $number with you from the Seefin app. Download Seefin from the play store / App Store to find reliable service providers in Nigeria. \n\nSeefin.",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        minimum: EdgeInsets.zero,
        maintainBottomViewPadding: false,
        child: ListView(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.blue,
              elevation: 0.0,
              title: Text(
                "Profile",
              ),
              centerTitle: true,
            ),
            Container(
              height: 350,
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image(
                      image: AssetImage("assets/images/background2.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.blue.withOpacity(0.6),
                          child: Icon(
                            Icons.person,
                            size: 80,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                        Text(
                          "$name",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          "$expertise",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(onPressed: (){
                              
                          getCurrentUser();
                       
                           _firestore.collection("notifications").document("$email").collection("chat_notifications").document("$loggedinuseremail").setData(
                      {"messagae": "$loggedinuserusername started a chat with you",
                      "email": loggedinuseremail,
                      "firstname": loggedinuserfirstname,
                      "lastname": loggedinuserlastname,
                      "phonenumber": loggedinuserphonenumber,
                      "username": loggedinuserusername
                      }
                    );
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ChatPage(loggedinuseremail,loggedinuserusername,email,name)));

                        },child: Text("Chat with $name"),color: Colors.lime,),
                        Padding(padding: EdgeInsets.only(right: 15)),

           Builder(
                      builder: (BuildContext context) => RaisedButton(onPressed: (){
    share(context);
                
                          },child: Text("Share with contact"),color: Colors.lime),
           )

                          ],
                        )                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("reviews")
                    .document("$email")
                    .collection("${name}_reviews")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  var count1 = 0.0;
                  var count2 = 0.0;
                  final message = snapshot.data.documents;
                  List<Widget> handymanrating = [];
                  List<Widget> handymanrating2 = [];

                  for (var item in message) {
                    final sender = item.data['sender'];
                    final servicerating = item.data['servicerating'];
                    final costrating = item.data['costrating'];
                    final date = item.data['date'];
                    final message = item.data['message'];
                    count1 += servicerating;
                    count2 += costrating;
                  }

                  count1 /= message.length;
                  count2 /= message.length;
                  final all = Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Overall Rating:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SmoothStarRating(
                            borderColor: Colors.teal,
                            starCount: 5,

                            rating: (count1 + count2) / 2,
                            size: 30,
                            //   filledIconData: Icons.blur_off,
                            //halfFilledIconData: Icons.blur_on,
                            color: Colors.teal,
                            spacing: 0.0,
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Service Rating:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SmoothStarRating(
                            borderColor: Colors.teal,
                            starCount: 5,

                            rating: count1,
                            size: 30,
                            //   filledIconData: Icons.blur_off,
                            //halfFilledIconData: Icons.blur_on,
                            color: Colors.teal,
                            spacing: 0.0,
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Cost Rating:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SmoothStarRating(
                            borderColor: Colors.teal,
                            starCount: 5,

                            rating: count2,
                            size: 30,
                            //   filledIconData: Icons.blur_off,
                            //halfFilledIconData: Icons.blur_on,
                            color: Colors.teal,
                            spacing: 0.0,
                          ),
                        ],
                      )
                    ],
                  );

                  final all2 = Center(
                    child: SmoothStarRating(
                      borderColor: Colors.teal,
                      starCount: 5,
                      rating: 0,
                      size: 35,
                      //   filledIconData: Icons.blur_off,
                      //halfFilledIconData: Icons.blur_on,
                      color: Colors.teal,
                      spacing: 0.0,
                    ),
                  );
                  handymanrating.add(all);
                  handymanrating2.add(all2);

                  return Column(
                    children:
                        message.length == 0 ? handymanrating2 : handymanrating,
                  );
                }),
            Padding(padding: EdgeInsets.only(top: 15)),
            Divider(
              thickness: 3.0,
              color: Colors.black.withOpacity(0.5),
            ),
            Text(
              "$name's contact details",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Container(
              //  color: Colors.brown,
              child: ListTile(
                leading: Icon(
                  Icons.phone_in_talk,
                  color: Colors.black,
                ),
                title: Text("$number"),
                trailing: RaisedButton(
                  color: Colors.teal,
                  onPressed: () {
                    _firestore.collection("notifications").document("$email").collection("call_notifications").document("$loggedinuseremail").setData(
                      {"messagae": "$loggedinuserusername tried to call you",
                      "email": loggedinuseremail,
                      "firstname": loggedinuserfirstname,
                      "lastname": loggedinuserlastname,
                      "phonenumber": loggedinuserphonenumber,
                      "username": loggedinuserusername
                      }
                    );
                    launch("tel:$number");
                  },
                  child: Text("Call"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Container(
              //    color: Colors.brown,
              child: ListTile(
                leading: Icon(Icons.message, color: Colors.black),
                title: Text("$number"),
                trailing: RaisedButton(
                  color: Colors.teal,
                  onPressed: () {
                     _firestore.collection("notifications").document("$email").collection("sms_notifications").document("$loggedinuseremail").setData(
                      {"messagae": "$loggedinuserusername tried to send you an SMS",
                      "email": loggedinuseremail,
                      "firstname": loggedinuserfirstname,
                      "lastname": loggedinuserlastname,
                      "phonenumber": loggedinuserphonenumber,
                      "username": loggedinuserusername
                      }
                    );
                    launch("sms:$number");
                  },
                  child: Text("SMS"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Container(
              //  color: Colors.brown,
              child: ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.black),
                title: Text("$email"),
                trailing: RaisedButton(
                  color: Colors.teal,
                  onPressed: () {
                     _firestore.collection("notifications").document("$email").collection("email_notifications").document("$loggedinuseremail").setData(
                      {"messagae": "$loggedinuserusername tried to email you",
                      "email": loggedinuseremail,
                      "firstname": loggedinuserfirstname,
                      "lastname": loggedinuserlastname,
                      "phonenumber": loggedinuserphonenumber,
                      "username": loggedinuserusername
                      }
                    );
                    launch("mailto:$email");
                  },
                  child: Text("Email"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Text(
              "$name's reviews",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 3.0,
              color: Colors.black.withOpacity(0.5),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection("reviews")
                        .document("$email")
                        .collection("${name}_reviews")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      final message = snapshot.data.documents;
                      List<Widget> reviews = [];
                      for (var item in message) {
                        final sender = item.data['sender'];
                        final servicerating = item.data['servicerating'];
                        final costrating = item.data['costrating'];
                        final date = item.data['date'];
                        final message = item.data['message'];

                        final all = Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.person),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Text(
                                    "$sender",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Row(
                                children: <Widget>[
                                  Text("Service rating:"),
                                  SmoothStarRating(
                                    borderColor: Colors.teal,
                                    starCount: 5,
                                    rating: servicerating,
                                    size: 20,
                                    //   filledIconData: Icons.blur_off,
                                    //halfFilledIconData: Icons.blur_on,
                                    color: Colors.teal,
                                    spacing: 0.0,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Cost rating:"),
                                  SmoothStarRating(
                                    borderColor: Colors.teal,
                                    starCount: 5,
                                    rating: costrating,
                                    size: 20,
                                    //   filledIconData: Icons.blur_off,
                                    //halfFilledIconData: Icons.blur_on,
                                    color: Colors.teal,
                                    spacing: 0.0,
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "$message",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "$date",
                                    style: TextStyle(color: Colors.teal),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                        reviews.add(all);
                      }
                      return Column(
                        children: reviews.length < 10 ? reviews : null,
                      );
                    })
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) => SimpleDialog(
                      title: Text(
                        "Leave Review",
                        textAlign: TextAlign.center,
                      ),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Service rating:"),
                            Center(
                              child: SmoothStarRating(
                                onRatingChanged: (v) {
                                     if(this.mounted){
                                  setState(() {
                                    userservicerating = v;
                                  });}
                                },
                                allowHalfRating: true,
                                borderColor: Colors.teal,
                                starCount: 5,
                                rating: userservicerating,
                                size: 40,
                                //   filledIconData: Icons.blur_off,
                                //halfFilledIconData: Icons.blur_on,
                                color: Colors.teal,
                                spacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        Column(
                          children: <Widget>[
                            Text("Cost rating:"),
                            Center(
                              child: SmoothStarRating(
                                onRatingChanged: (v) {
                                     if(this.mounted){
                                  setState(() {
                                    usercostrating = v;
                                  });}
                                },
                                allowHalfRating: true,
                                borderColor: Colors.teal,
                                starCount: 5,
                                rating: usercostrating,
                                size: 40,
                                //   filledIconData: Icons.blur_off,
                                //halfFilledIconData: Icons.blur_on,
                                color: Colors.teal,
                                spacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        TextFormField(
                          controller: message,
                          decoration: InputDecoration(labelText: "Message"),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                        RaisedButton(
                          onPressed: () async {
                            DateTime date = new DateTime.now();
                            var day = date.day;
                            var month = date.month;
                            var year = date.year;
                            var user = await _auth.currentUser();
                            _firestore
                                .collection("reviews")
                                .document("$email")
                                .collection("${name}_reviews")
                                .document("Review by ${user.email}")
                                .setData({
                              "sender": user.email,
                              "servicerating": userservicerating,
                              "costrating": usercostrating,
                              "date": "$day/$month/$year",
                              "message": message.text,
                            });
                            var count1 = 0.0;
                            var count2 = 0.0;
                            final sn = await _firestore
                                .collection("reviews")
                                .document("$email")
                                .collection("${name}_reviews")
                                .getDocuments();
                            for (var item in sn.documents) {
                              var servicerating = item.data['servicerating'];
                              var costrating = item.data['costrating'];
                              count1 += servicerating;
                              count2 += costrating;
                            }

                            count1 /= sn.documents.length;
                            count2 /= sn.documents.length;
                            _firestore
                                .collection("verifiedserviceproviders")
                                .document("$location")
                                .collection("$expertise")
                                .document("$email")
                                .setData(
                              {
                                "costrating": count2.toString(),
                                "email": email,
                                "firstname": firstname,
                                "lastname": lastname,
                                "location": location,
                                "password": password,
                                "phonenumber": number,
                                "servicerating": count1.toString(),
                                "specialization": expertise,
                                "username": name,
                              },
                            );

                            _firestore
                                .collection("allverifiedserviceproviders")
                                .document("$email")
                                .setData(
                              {
                                "costrating": count2.toString(),
                                "email": email,
                                "firstname": firstname,
                                "lastname": lastname,
                                "location": location,
                                "password": password,
                                "phonenumber": number,
                                "servicerating": count1.toString(),
                                "specialization": expertise,
                                "username": name,
                              },
                            );

                            _firestore
                                .collection("allusers")
                                .document("$email")
                                .setData(
                              {
                                "costrating": count2.toString(),
                                "email": email,
                                "firstname": firstname,
                                "lastname": lastname,
                                "location": location,
                                "password": password,
                                "phonenumber": number,
                                "servicerating": count1.toString(),
                                "specialization": expertise,
                                "username": name,
                              },
                            );
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => SimpleDialog(
                                      children: <Widget>[
                                        Text(
                                          "Your Rating has been collected. Thank you for improving Seefin ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 15)),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Close"),
                                          color: Colors.blue,
                                        )
                                      ],
                                    ));
                          },
                          child: Text("Send Review"),
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ));
          /* _firestore
                                        .collection("allusers")
                                        .document("$name")
                                        .setData(
                                      {
                                        "email": "$email",
                                        "username": "$name",
                                        "phonenumber": "$number",
                                        "password": "$password",
                                        "specialization": "$expertise",
                                        "location": "$location",
                                        "reviews": 5
                                      },
                                    );*/
        },
        label: Text("Rate Service Provider"),
      ),
    );
  }
}
