import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handymen/chatscreen.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  var count = 0;
  var loggedinuserusername;
  var loggedinuserfirstname;
  var loggedinuserlastname;
  var loggedinuseremail;
  var loggedinuserphonenumber;
  getUserDetails() async {
    final FirebaseUser user = await _auth.currentUser();
    var useremail = user.email.toString();
    loggedinuseremail = useremail;
    if (loggedinuseremail != null) {
      if (count == 0) {
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
      } else {}
    }
  }

  getStreams(String title, String notificationtype) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("notifications")
            .document("$loggedinuseremail")
            .collection(notificationtype)
            .snapshots(),
        builder: (context, snapshot) {
          getUserDetails();
          if (!snapshot.hasData) {
            return Container();
          }
          final message = snapshot.data.documents;
          List<Widget> handymen = [];

          for (var item in message) {
            final email = item.data['email'];
            final firstname = item.data['firstname'];
            final lastname = item.data['lastname'];
            final message = item.data['messagae'];
            final number = item.data['phonenumber'];
            final username = item.data['username'];
       

            final all = Container(
                margin: EdgeInsets.only(bottom: 20),
                // width: 300,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.cancel),
                    iconSize: 30,
                    color: Colors.black,
                    onPressed: () {
                      _firestore
                          .collection("notifications")
                          .document("$loggedinuseremail")
                          .collection(notificationtype)
                          .document("$email")
                          .delete();
                    },
                  ),
                  title: Text("$title"),
                  subtitle: Text("$message"),
                  trailing: RaisedButton(
                    onPressed: () {
                      launch("tel:$number");
                    },
                    child: Text("Call"),
                  ),
                ));
            handymen.add(all);
          }

          return Column(
            children: handymen,
          );
        });
  }

  getChatStreams(String notificationtype) {
     return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("notifications")
            .document("$loggedinuseremail")
            .collection(notificationtype)
            .snapshots(),
        builder: (context, snapshot) {
          getUserDetails();
          if (!snapshot.hasData) {
            return Container();
          }
          final message = snapshot.data.documents;
          List<Widget> handymen = [];

          for (var item in message) {
            final email = item.data['email'];
            final firstname = item.data['firstname'];
            final lastname = item.data['lastname'];
            final message = item.data['messagae'];
            final number = item.data['phonenumber'];
            final username = item.data['username'];
         

            final all = Container(
                margin: EdgeInsets.only(bottom: 20),
                // width: 300,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.cancel),
                    iconSize: 30,
                    color: Colors.black,
                    onPressed: () {
                      _firestore
                          .collection("notifications")
                          .document("$loggedinuseremail")
                          .collection(notificationtype)
                          .document("$email")
                          .delete();
                    },
                  ),
                  title: Text("Chat Notification"),
                  subtitle: Text("$message"),
                  trailing: RaisedButton(
                    onPressed: () {
                      _firestore
                          .collection("notifications")
                          .document("$email")
                          .collection("chat_notifications")
                          .document("$loggedinuseremail")
                          .setData({
                        "messagae":
                            "$loggedinuserusername started a chat with you",
                        "email": loggedinuseremail,
                        "firstname": loggedinuserfirstname,
                        "lastname": loggedinuserlastname,
                        "phonenumber": loggedinuserphonenumber,
                        "username": loggedinuserusername
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ChatPage(
                                  loggedinuseremail,
                                  loggedinuserusername,
                                  email,
                                  username)));
                    },
                    child: Text("Chat"),
                  ),
                ));
            handymen.add(all);
          }

          return Column(
            children: handymen,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 30)),
        getStreams("Call Notification","call_notifications"),
        getChatStreams("chat_notifications"),
        getStreams("Email Notification","email_notifications"),
        getStreams("SMS Notification","sms_notifications"),
      ],
    ));
  }
}
