import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database/database.dart';

Color activeColor = Color(0xff7a8fb3);
Color titleColor = Color(0xff606060);
Color textColor = Color(0xff6d6d6d);
Color articleTitleColor = Color(0xff7f786e);
Color articleSubtitleColor = Color(0xff978f86);
Color lightGray = Color(0xffeff1f2);
Color commentColor = Color(0xffd1e4e2);

FirebaseAuth firebaseAuth;
FirebaseDatabase firebaseDatabase;
FirebaseStorage firebaseStorage;
Firestore firestore;

Database database;

Function fetchData;
Function(int) selectTab;