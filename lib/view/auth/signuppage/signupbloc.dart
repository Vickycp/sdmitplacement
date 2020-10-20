import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class SignupBloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _username = BehaviorSubject<String>();
  final _usn = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmpassword = BehaviorSubject<String>();
  final _loading = PublishSubject<bool>();
  final _signupsucess = BehaviorSubject<String>();

  final _googleloading = PublishSubject<bool>();

  Stream<String> get usernamestream =>
      _username.stream.transform(usertransform);
  Stream<String> get usnstream => _usn.stream.transform(usntransform);
  Stream<String> get emailstream => _email.stream.transform(emailtransform);
  Stream<String> get passwordstream =>
      _password.stream.transform(passwordtransform);
  Stream<String> get confirmpassword =>
      _confirmpassword.stream.transform(confirmpasswordtransform);
  Stream<bool> get loading => _loading.stream;
  Stream<String> get signupsuccess => _signupsucess.stream;
  Stream<bool> get googleloading => _googleloading.stream;

  Function(String) get usernamesink => _username.sink.add;
  Function(String) get usnsink => _usn.sink.add;
  Function(String) get emailsink => _email.sink.add;
  Function(String) get passwordsink => _password.sink.add;
  Sink get confirmpasswordsink => _confirmpassword.sink;

  Stream<bool> get enable => Rx.combineLatest5(usernamestream, usnstream,
      emailstream, passwordstream, confirmpassword, (a, b, c, d, e) => true);

  matchpassword(String val) {
    if (val == _password.value) {
      confirmpasswordsink.add("match");
    } else {
      confirmpasswordsink.add("not match");
    }
  }

  signup(BuildContext context) async {
     BlocProvider.of<AuthblocBloc>(context).add(Detailsevent());
    // _loading.sink.add(true);
    // await _auth
    //     .createUserWithEmailAndPassword(
    //         email: _email.value, password: _password.value)
    //     .then((value) async {
    //   _signupsucess.sink.add((value.user).email);

    //   await _firestore.collection('studentcredential').doc().set({
    //     'email': _email.value,
    //     'password': _password.value,
    //     'username': _username.value,
    //     'usn': _usn.value
    //   });
    //  BlocProvider.of<AuthblocBloc>(context).add(Detailsevent());
    // }).catchError((error) {
    //   _signupsucess.sink.addError(error.code);
    //   _loading.sink.add(false);
    // });
    // _loading.sink.add(false);
  }

  googlesignup(BuildContext context) async {
    _googleloading.sink.add(true);
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth
        .signInWithCredential(credential)
        .then((value)async {

         _signupsucess.sink.add((value.user).email);
      await _firestore.collection('studentcredential').doc().set({
        'email': (value.user).email,
        'password':null,
        'username':(value.user).displayName,
        'usn': (value.user).displayName
      });
       BlocProvider.of<AuthblocBloc>(context).add(Detailsevent());

        })
        .catchError((error) {
  _signupsucess.sink.addError(error.code);
      _googleloading.sink.add(false);

        });
    _googleloading.sink.add(false);
  }

  final usertransform = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length > 3) {
        sink.add(data);
      } else {
        sink.addError("username should be greater than 3 letters");
      }
    },
  );
  final usntransform = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      bool usnvalidate(usn) {
        String validusn = r'^[1-4][a-z,A-Z]{2}[0-9]{2}[a-z,A-Z]{2}[0-9]{3}$';
        RegExp exp = RegExp(validusn);
        return exp.hasMatch(usn);
      }

      if (usnvalidate(data)) {
        sink.add(data);
      } else {
        sink.addError("usn not valid");
      }
    },
  );
  final emailtransform = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      bool isEmail(String email) {
        // print(email);
        String p =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

        RegExp regExp = new RegExp(p);

        return regExp.hasMatch(email);
      }

      if (isEmail(data)) {
        sink.add(data);
      } else {
        sink.addError("email not correct");
      }
    },
  );
  final passwordtransform = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length > 6) {
        sink.add(data);
      } else {
        sink.addError("password greater then 6");
      }
    },
  );
  final confirmpasswordtransform =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      print(data);
      if (data.length > 6) {
        sink.add(data);
      }
    },
  );

  void dispose() {
    _username.close();
    _usn.close();
    _email.close();
    _password.close();
    _confirmpassword.close();
    _loading.close();
    _signupsucess.close();
    _googleloading.close();
  }
}
