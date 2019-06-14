import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;

  @override
  void initState() {
    super.initState();
    readDatabase(context);
    // testAdd();
    readFireStore();
  }

  Future readFireStore() async {
    CollectionReference collectionReference = firestore.collection('Post');
    subscription = await collectionReference.snapshots().listen((dataSnapshot) {
      snapshots = dataSnapshot.documents;

      for (var snapshot in snapshots) {
        String title = snapshot.data['Title'];
        String content = snapshot.data['Content'];

        print('title ==> $title, content ==> $content');
      }
    });
  }

  Future testAdd() async {
    Map<String, dynamic> map = Map();
    map['Content'] = 'Test Content by master1234';
    map['Title'] = 'Test Title by master';

    await firestore.collection('Post').document().setData(map).then((value) {
      print('Update to FireStore OK');
    });
  }

  Future readDatabase(BuildContext context) async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    var objData = await firebaseDatabase.reference().child('User');
    StreamBuilder(
      stream: objData.onValue,
      builder: (BuildContext context, snap) {
        DataSnapshot dataSnapshot = snap.data;
        print(dataSnapshot.value);
      },
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        signOutProcess();
      },
    );
  }

  void signOutProcess() {
    firebaseAuth.signOut().then((objValue) {
      exit(0);
    });
  }

  Widget showTitle() {
    return ListTile(
      title: Text(
        'My Service',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Welcome',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showTitle(),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('body'),
    );
  }
}
