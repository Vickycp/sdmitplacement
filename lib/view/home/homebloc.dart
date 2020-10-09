import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sdmitplacement/view/auth/authbackend/connections.dart';

class HomeBloc {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _store = FirebaseFirestore.instance;
  final isloginin = BehaviorSubject<bool>();

  Stream<bool> get userpresent => isloginin.stream;
  // Function(bool) get usersink => _isloginin.sink.add;

  logout() {
    FirebaseAuth.instance.signOut();
    isloginin.sink.add(false);
  }
 lo(){
   isloginin.sink.add(true);
 }



  dispose() {
    isloginin.close();
  }
}
