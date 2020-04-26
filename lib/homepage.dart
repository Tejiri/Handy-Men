import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handymen/chatscreen.dart';
import 'package:handymen/handymanprofile.dart';
import 'package:handymen/loginpage.dart';
import 'package:handymen/registrationtype.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var loggedinuserusername;
  var loggedinuserfirstname;
  var loggedinuserlastname;
   var loggedinuseremail;
   var loggedinuserphonenumber;
   var count =0;
  getUserDetails() async {
    
    final FirebaseUser user = await _auth.currentUser();
    var useremail = user.email.toString();
     loggedinuseremail = useremail;
    if(loggedinuseremail != null){

  if(count ==0){
 var document = await _firestore
        .collection("allusers")
        .document("$loggedinuseremail")
        .get();
           if(this.mounted){
        setState(() {
         
           loggedinuserusername = document['username'];
    loggedinuserfirstname = document['firstname'];
    loggedinuserlastname = document['lastname'];
    loggedinuserphonenumber = document['phonenumber'];
        });}
        count++;
  }else{

    }
   
    }
  }

  TextEditingController text = new TextEditingController();
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Seefin",
    style: TextStyle(color: Colors.white),
  );

  var name;
  var searchlist = [];
  TextEditingController username = TextEditingController();
  TextEditingController expertise = TextEditingController();
  TextEditingController number = TextEditingController();
  String currentlocation;
  String currentspecialization;
  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
 

  var location = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "F.C.T",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara"
  ];
  var specialization = [
    "Electrician",
    "Plumber",
    "Tailor",
    "Barber",
    "Carpenter",
    "Mechanic",
    "Hair dresser"
  ];
  
  

  void share(
    BuildContext context,
  ) {
    final RenderBox box = context.findRenderObject();

    Share.share(
        "Hello, \n\nJoin $loggedinuserfirstname $loggedinuserlastname at Seefin to find reliable service providers in Nigeria, download from the Play store or App Store. \n\nSeefin.",
        subject: "Join $loggedinuserfirstname $loggedinuserlastname at Seefin",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  body1() {
  
    getUserDetails();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.blue,
              child: Image(
                image: AssetImage("assets/images/2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50)),
                Text(
                  "Welcome to Seefin",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Text(
                  "Connecting you with reliable service providers",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25)),
                      margin: EdgeInsets.only(top: 90),
                      height: 100,
                      width: 200,
                      child: Center(
                          child: currentlocation == null
                              ? Text(
                                  "Select a location",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  "Service Providers in $currentlocation",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ))),
                ),
              ],
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Column(
          children: <Widget>[
            Container(
              width: 300,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
              ),
              // width: ,
              child: DropdownButton<String>(
                autofocus: false,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                hint: Text("Select your location"),
                items: location.map((String dropitem) {
                  return DropdownMenuItem<String>(
                      value: dropitem, child: Text(dropitem));
                }).toList(),
                onChanged: (String newitem) {
                     if(this.mounted){
                  setState(() {
                    this.currentlocation = newitem;
                  });}
                },
                value: currentlocation,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Container(
              width: 300,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
              ),
              // width: ,
              child: DropdownButton<String>(
                autofocus: false,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                hint: Text("Select your Specilization"),
                items: specialization.map((String dropitem) {
                  return DropdownMenuItem<String>(
                      value: dropitem, child: Text(dropitem));
                }).toList(),
                onChanged: (String newitem) {
                     if(this.mounted){
                  setState(() {
                    this.currentspecialization = newitem;
                  });}
                },
                value: currentspecialization,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
          color: Colors.blueAccent.withOpacity(0.9),
          width: double.infinity,
          height: 60,
          child: currentspecialization == null || currentlocation == null
              ? Center(
                  child: Text(
                  "specify a location and specialization",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ))
              : Center(
                  child: Text(
                  "$currentspecialization's in $currentlocation",
                  style: TextStyle(fontSize: 25),
                )),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("allverifiedserviceproviders")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final message = snapshot.data.documents;
                  List<Widget> handymen = [];

                  for (var item in message) {
                    if (currentlocation == item.data['location'] &&
                        currentspecialization == item.data['specialization']) {
                      final checkemail = item.data['email'];
                      if (loggedinuseremail == checkemail.toString()) {
                      } else {
                        final costrating = item.data['costrating'];
                        final email = item.data['email'];
                        final firstname = item.data['firstname'];
                        final lastname = item.data['lastname'];
                        final location = item.data['location'];
                        final password = item.data['password'];
                        final number = item.data['phonenumber'];
                        final servicerating = item.data['servicerating'];
                        final expertise = item.data['specialization'];
                        final name = item.data['username'];

                        final all = Container(
                            margin: EdgeInsets.only(bottom: 15),
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/tool1.gif"),
                              ),
                              title: Text("$name"),
                              subtitle: SmoothStarRating(
                                borderColor: Colors.teal,
                                starCount: 5,
                                rating: (double.parse(servicerating) +
                                        double.parse(costrating)) /
                                    2,
                                size: 10,
                                //   filledIconData: Icons.blur_off,
                                //halfFilledIconData: Icons.blur_on,
                                color: Colors.teal,
                                spacing: 0.0,
                              ),
                              trailing: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                       
                                              HandyManProfile(
                                                "$loggedinuserfirstname",
"$loggedinuserlastname",
"$loggedinuserphonenumber",
                                                  "$loggedinuseremail",
                                                  "$loggedinuserusername",
                                                  "$email",
                                                  "$firstname",
                                                  "$lastname",
                                                  "$location",
                                                  "$password",
                                                  "$name",
                                                  "$number",
                                                  "$expertise",
                                                  "$servicerating",
                                                  "$costrating")));
                                  //  launch("tel:$number");
                                },
                                child: Text("Contact"),
                              ),
                            ));
                        handymen.add(all);
                      }
                    }
                  }
                  return Column(
                    children: handymen,
                  );
                }),
            Padding(padding: EdgeInsets.only(bottom: 70))
          ],
        ),
      ],
    );
  }

  body2() {
    getUserDetails();
    return ListView(
      //  mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection("allverifiedserviceproviders")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final message = snapshot.data.documents;
              List<Widget> handymen = [];
              for (var item in message) {
                final checkemail = item.data['email'];
                if (loggedinuseremail == checkemail) {
                } else if (searchlist.contains(item.data['username'])) {
                  final email = item.data['email'];
                  final firstname = item.data['firstname'];
                  final lastname = item.data['lastname'];
                  final location = item.data['location'];
                  final password = item.data['password'];
                  final name = item.data['username'];
                  final number = item.data['phonenumber'];
                  final expertise = item.data['specialization'];
                  final servicerating = item.data['servicerating'];
                  final costrating = item.data['costrating'];

                  final all = Container(
                      margin: EdgeInsets.only(top: 20),
                      //width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/tool1.gif"),
                        ),
                        title: Text("$name"),
                        subtitle: SmoothStarRating(
                          borderColor: Colors.teal,
                          starCount: 5,
                          rating: (double.parse(servicerating) +
                                  double.parse(costrating)) /
                              2,
                          size: 10,
                          //   filledIconData: Icons.blur_off,
                          //halfFilledIconData: Icons.blur_on,
                          color: Colors.teal,
                          spacing: 0.0,
                        ),
                        trailing: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HandyManProfile(
                                               "$loggedinuserfirstname",
"$loggedinuserlastname",
"$loggedinuserphonenumber",
                                            "$loggedinuseremail",
                                            "$loggedinuserusername",
                                            "$email",
                                            "$firstname",
                                            "$lastname",
                                            "$location",
                                            "$password",
                                            "$name",
                                            "$number",
                                            "$expertise",
                                            "$servicerating",
                                            "$costrating")));
                            //  launch("tel:$number");
                          },
                          child: Text("Contact"),
                        ),
                      ));
                  handymen.add(all);
                }
              }

              return Column(
                children: handymen,
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: cusSearchBar,
        //leading: Container(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: cusIcon,
              onPressed: () {
                   if(this.mounted){
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      onChanged: (value) async {
                        List test = [];
                        final all = await _firestore
                            .collection("allusers")
                            .getDocuments();
                        for (var item in all.documents) {
                          var currentname =
                              item['username'].toString().toLowerCase();
                          if (currentname.contains(value)) {
                               if(this.mounted){
                            setState(() {
                              test.add(item['username']);
                            });}
                               if(this.mounted){
                            setState(() {
                              searchlist = test;
                            });}
                            // test.add(item['username']);
                        
                          }
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter search here",
                          border: InputBorder.none),
                      textInputAction: TextInputAction.go,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text(
                      "Seefin",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                });}
              })
        ],
      ),
      body: this.cusIcon.icon == Icons.search ? body1() : body2(),
      floatingActionButton: Builder(
          builder: (BuildContext context) => FloatingActionButton(
                onPressed: () {
                  share(context);
                },
                child: Icon(Icons.share),
                backgroundColor: Colors.blueAccent.withOpacity(0.0),
              )),
      drawer: SafeArea(
        
        child: Drawer(
          child: Column(
           
            children: <Widget>[
           
               GestureDetector(
                 onTap: (){
_auth.signOut();
 Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginPage()));
                 },
                                child: Container(
                 color: Colors.blueAccent,
                 width: double.infinity,
                 height: 50,
                 child: Center(child: Text("My Chat List",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
             ),
               ),
              
             
             
              loggedinuseremail == null? CircularProgressIndicator():
               StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection("chatlist_$loggedinuseremail")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final message = snapshot.data.documents;
              List<Widget> handymen = [];
              for (var item in message) {
              
                  final senderemail = item.data['email'];
                  final senderusername = item.data['username'];
                

                  final all = Container(
                      margin: EdgeInsets.only(top: 20),
                      //width: 300,
                      decoration: BoxDecoration(
                      //    color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: ListTile(
                        leading: CircleAvatar(
                         child: Icon(Icons.person),
                        ),
                        title: Text("$senderusername"),
                       
                        trailing: RaisedButton(
                          onPressed: () {
                           Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ChatPage(
                            loggedinuseremail,
                            loggedinuserusername,
                            senderemail,
                            senderusername)));
                          },
                          child: Text("Continue Chat"),
                        ),
                      ));
                  handymen.add(all);
                
              }

              return Column(
                children: handymen,
              );
            })
            ],
          ),
        ),
      ),
    );
  }
}
