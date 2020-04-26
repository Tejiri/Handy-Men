import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handymen/homepage.dart';
import 'package:handymen/loginpage.dart';
import 'package:handymen/myprofile.dart';
import 'package:handymen/notifications.dart';
import 'package:handymen/registrationtype.dart';

class BottomNavigation extends StatefulWidget {
  int selectedindex;
  BottomNavigation(this.selectedindex);
  @override
  _BottomNavigationState createState() => _BottomNavigationState(selectedindex);
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedindex;

  _BottomNavigationState(this.selectedindex);

  var _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  var count = 0;
  var count1;
  var count2;
  var count3;
  var count4;
  var count5;
  var loggedinuserusername;
  var loggedinuserfirstname;
  var loggedinuserlastname;
  var loggedinuseremail;
  var loggedinuserphonenumber;
  @override
  void initState() {
    super.initState();
    getUserDetails();
    notificationsCount();
  }

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

  notificationsCount() async {
    final doc1 = await _firestore
        .collection("notifications")
        .document("$loggedinuseremail")
        .collection("call_notifications")
        .getDocuments();
    final doc2 = await _firestore
        .collection("notifications")
        .document("$loggedinuseremail")
        .collection("call_notifications")
        .getDocuments();
    final doc3 = await _firestore
        .collection("notifications")
        .document("$loggedinuseremail")
        .collection("chat_notifications")
        .getDocuments();
    final doc4 = await _firestore
        .collection("notifications")
        .document("$loggedinuseremail")
        .collection("email_notifications")
        .getDocuments();
    final doc5 = await _firestore
        .collection("notifications")
        .document("$loggedinuseremail")
        .collection("sms_notifications")
        .getDocuments();
           if(this.mounted){
    setState(() {
      count1 = doc2.documents.length;

      count2 = doc2.documents.length;

      count3 = doc3.documents.length;

      count4 = doc4.documents.length;

      count5 = count1 + count2 + count3 + count4;
    });}

    
  }

  final List<Widget> _children = [NotificationsPage(), HomePage(), MyProfile()];
  void _onTap(int index) {
       if(this.mounted){
    setState(() {
      selectedindex = index;
    });}
  }

  Widget myicon = Icon(Icons.notifications);
geting(){
     if(this.mounted){
  setState(() {
    myicon = Icon(Icons.notifications_active);
  });}

}

getting(){
     if(this.mounted){
  setState(() {
    myicon = Icon(Icons.notifications);
  });}
  return myicon;
}
geting2(){
     if(this.mounted){
  setState(() {
    myicon = Icon(Icons.notifications_active,color: Colors.green);
  });}
  return myicon;

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: count5 == null || count5 == 0
                ? getting(): geting2() ,
               
            title: Text("Notifications"),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
        ],
        currentIndex: selectedindex,
        selectedItemColor: Colors.amber[800],
        onTap: _onTap,
      ),
    );
  }
}
