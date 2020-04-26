import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  var useremail;
  var username;
  var provideremail;
  var providername;
  ChatPage(
      this.useremail, this.username, this.provideremail, this.providername);
  @override
  _ChatPageState createState() =>
      _ChatPageState(useremail, username, provideremail, providername);
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  var useremail;
  var username;
  var provideremail;
  var providername;
  _ChatPageState(
      this.useremail, this.username, this.provideremail, this.providername);

  var loggedinuserusername;
  var loggedinuserfirstname;
  var loggedinuserlastname;
  var loggedinuseremail;
  var loggedinuserphonenumber;
  var count = 0;
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
              
        setState(() {
          loggedinuserusername = document['username'];
          loggedinuserfirstname = document['firstname'];
          loggedinuserlastname = document['lastname'];
          loggedinuserphonenumber = document['phonenumber'];
        });
        count++;
      } else {}
    }
  }

  addMessage(String time, String mydocument) {
    _firestore
        .collection("chats")
        .document("$provideremail")
        .collection("$useremail chat")
        .document(mydocument)
        .setData({
      "message": message.text,
      "senderemail": useremail,
      "senderusername": username,
      "time": time
    });
    _firestore
        .collection("chatlist_$provideremail")
        .document("$useremail")
        .setData({"email": useremail, "username": username});

    _firestore
        .collection("chatlist_$useremail")
        .document("$provideremail")
        .setData({"email": provideremail, "username": providername});

    _firestore
        .collection("chats")
        .document("$useremail")
        .collection("$provideremail chat")
        .document(mydocument)
        .setData({
      "message": message.text,
      "senderemail": useremail,
      "senderusername": username,
      "time": time
    });
  }

  firstMessage(String time, String mydocument) {
    _firestore
        .collection("chats")
        .document("$provideremail")
        .collection("$useremail chat")
        .document(mydocument)
        .setData({
      "message": "Welcome to the chat section",
      "senderemail": useremail,
      "senderusername": "Emoghene-Ijatomi Tejiri Stephen",
      "time": time
    });

    _firestore
        .collection("chats")
        .document("$useremail")
        .collection("$provideremail chat")
        .document(mydocument)
        .setData({
      "message": "Welcome to the chat section",
      "senderemail": useremail,
      "senderusername": "Emoghene-Ijatomi Tejiri Stephen (Admin)",
      "time": time
    });
    _firestore
        .collection("chatlist_$provideremail")
        .document("$useremail")
        .setData({"email": useremail, "username": username});

    _firestore
        .collection("chatlist_$useremail")
        .document("$provideremail")
        .setData({"email": provideremail, "username": providername});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("chats")
                      .document("$useremail")
                      .collection("$provideremail chat")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final message = snapshot.data.documents.reversed;
                    List<Widget> reviews = [];
                    List allmessages = [];
                    for (var item in message) {
                      final message = item.data['message'];
                      final senderemail = item.data['senderemail'];
                      final senderusername = item.data['senderusername'];
                      final time = item.data['time'];

                      if (senderemail == useremail) {
                        final all = Container(
                          //  decoration: ,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(message)),
                              Text(
                                senderusername,
                                style: TextStyle(),
                              )
                            ],
                          ),
                        );
                        reviews.add(all);
                      } else {
                        final all = Container(
                          //  decoration: ,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(message)),
                              Text(
                                senderusername,
                                style: TextStyle(),
                              )
                            ],
                          ),
                        );
                        reviews.add(all);
                      }
                    }
                    return Expanded(
                      child: ListView(reverse: true, children: reviews),
                    );
                  }),
              Container(
                height: 50,
                width: double.infinity,
                //  color: Colors.black,

                child: Wrap(children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.black.withOpacity(0.1)
                    ),
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () async {
                                 getUserDetails();
                                  _firestore.collection("notifications").document("$provideremail").collection("chat_notifications").document("$useremail").setData(
                      {"messagae": "$username sent you a chat message",
                      "email": "$loggedinuseremail",
                      "firstname": "$loggedinuserfirstname",
                      "lastname": "$loggedinuserlastname",
                      "phonenumber": "$loggedinuserphonenumber",
                      "username": "$loggedinuserusername"
                      });
                             
                                firstMessage("1", "1");
                                //   addMessage(1, "1");
                                int count = 0;

                                final doc = await _firestore
                                    .collection("chats")
                                    .document("$useremail")
                                    .collection("$provideremail chat")
                                    .getDocuments();
                                for (var message in doc.documents) {
                               
                                  count++;
                               
                                  if (count == doc.documents.length) {
                                
                                    var all = message.data['time'];
                                    String counttostring = "1$all";

                                    addMessage(counttostring, counttostring);
                                  }
                                }

                                //   var doc = count.toString();
                                //   addMessage(1,"Tejiri");
                                message.clear();
                              })),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
