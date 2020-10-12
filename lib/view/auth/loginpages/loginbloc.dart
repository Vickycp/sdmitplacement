import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class Loginbloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();




  final _emailcontroller = BehaviorSubject<String>();
  final BehaviorSubject _passwordcontroller = BehaviorSubject<String>();
  final PublishSubject _isloading = PublishSubject<bool>();
  final PublishSubject _googleloading = PublishSubject<bool>();
  final BehaviorSubject _showerrors = BehaviorSubject<String>();

  Stream<String> get email =>
      _emailcontroller.stream.transform(emailvalidation);
  Stream<String> get password =>
      _passwordcontroller.stream.transform(passwordvalidate);

  Stream<bool> get isloading => _isloading.stream;
  Stream<bool> get googleloading => _googleloading.stream;
  Stream get errorstream => _showerrors.stream;

  Function(String) get emailsink => _emailcontroller.sink.add;
  Function(String) get passwordsink => _passwordcontroller.sink.add;

  Stream<bool> get enable => Rx.combineLatest2(email, password, (a, b) => true);

  login(BuildContext context) async {
    _isloading.sink.add(true);
    await _auth
        .signInWithEmailAndPassword(
            email: _emailcontroller.value, password: _passwordcontroller.value)
        .then((value) {
      _showerrors.sink.add(value.user.email);
      BlocProvider.of<AuthblocBloc>(context).add(Userauthsuccess());
    }).catchError((error) {
      print(error);
      _showerrors.sink.addError(error.code);
      _isloading.sink.add(false);
    });
    _isloading.sink.add(false);
  }

  forgetpassword() {
    if (_emailcontroller.value == null) {
      _showerrors.sink.addError("please enter your email");
    }
    {
      _auth.sendPasswordResetEmail(email: _emailcontroller.value).then((_) {
        _showerrors.sink.add("reset, email set to your mail");
      }).catchError((error) {
        _showerrors.sink.addError(error.code);
      });
    }
  }

  googlesigin(BuildContext context) async {
    _googleloading.sink.add(true);
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // ignore: deprecated_member_use
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential).then((value) {
      _showerrors.sink.add(value.user.email);
       _googleloading.sink.add(false);
      BlocProvider.of<AuthblocBloc>(context).add(Userauthsuccess());
    }).catchError((error) {
      _showerrors.sink.addError(error.code);
       _googleloading.sink.add(false);
    });
     _googleloading.sink.add(false);
  }

  final emailvalidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      bool isEmail(String email) {
        // print(email);
        String p =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

        RegExp regExp = new RegExp(p);

        return regExp.hasMatch(email);
      }

      if (isEmail(email)) {
        sink.add(email);
      } else {
        sink.addError("not valid email");
      }
    },
  );

  final passwordvalidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError("password must be greater than 6");
      }
    },
  );

  dispose() {
    _emailcontroller.close();
    _passwordcontroller.close();
    _isloading.close();
    _showerrors.close();
    _googleloading.close();
  }
}
