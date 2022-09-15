import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'globals.dart' as globals;

import 'route_generator.dart';

void main() async {
  var app = await FirebaseApp.configure(
    name: 'db2',
    options: FirebaseOptions(
      googleAppID: Platform.isIOS
          ? '1:189711526043:ios:294c3e6fd5e8727e'
          : '1:189711526043:android:294c3e6fd5e8727e',
      gcmSenderID: '189711526043',
      apiKey: Platform.isIOS
          ? 'AIzaSyAmpU1ORqozQKJv3KX14b4D7XBnFjMdgGU'
          : 'AIzaSyALTP3LWG0CGj5dedu4YjotuIb02UzVLoM',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
      storageBucket: 'fir-img-id-trigger.appspot.com',
      projectID: 'fir-img-id-trigger',
    ),
  );

  globals.firebaseAuth = FirebaseAuth.fromApp(app);

  globals.firebaseDatabase = FirebaseDatabase(
    app: app
  );

  globals.firebaseStorage = FirebaseStorage(
    app: app
  );

  globals.firestore = Firestore(
    app: app
  );

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

