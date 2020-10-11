import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Firstcontrollerbloc {
  final _useristhere = BehaviorSubject<bool>();
  Stream<bool> get useristhere => _useristhere.stream;

  userpresent() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      print(event);
      if (event != null) {
        _useristhere.sink.add(true);
      } else if(event==null) {
        _useristhere.sink.add(false);
      }
    }).onError((e) {
      if (e) {
        _useristhere.sink.add(false);
      }
    });
  }

  void dispose() {
    _useristhere.close();
  }
}
