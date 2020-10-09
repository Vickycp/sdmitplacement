import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sdmitplacement/view/auth/authbackend/connections.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';

class SigninBloc {
  HomeBloc homebloc = HomeBloc();
  FirebaseAuth auth = FirebaseAuth.instance;
  final BehaviorSubject _email = BehaviorSubject<String>();
  final PublishSubject _valid = PublishSubject<String>();
  final _password = BehaviorSubject<String>();
  final PublishSubject _loading = PublishSubject<bool>();
  Stream<String> get emailstream => _email.stream.transform(emailvalidation);

  Stream<String> get passwordstream =>
      _password.stream.transform(passwordvalidation);

  Stream<bool> get loading => _loading.stream;
  Stream<String> get validationStream => _valid.stream;

  Function(String) get emailsink => _email.sink.add;

  Function(String) get passwordsink => _password.sink.add;

  Stream<bool> get enable =>
      Rx.combineLatest2(emailstream, passwordstream, (a, b) => true);

  submit() async {
    print(_email.value);
    print(_password.value);
    _loading.sink.add(true);

    // Connections().signin(email: _email.value, password: _password.value);

    await auth
        .signInWithEmailAndPassword(
            email: _email.value, password: _password.value)
        .then((value) {
      print(value.user.email + "Dddd");
      _valid.sink.add(value.user.email);
           homebloc.isloginin.sink.add(true);
    }).catchError((e) {
      print(e.message);
      _valid.sink.addError(e.code);
      _loading.sink.add(false);
      homebloc.isloginin.sink.add(false);
    });
    _loading.sink.add(false);
  }

   signup({username, email, password}) {
 

    
      homebloc.isloginin.sink.add(true);


   
  }

  final emailvalidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
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
      sink.addError("email not correct");
    }
  });
  final passwordvalidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError("password must be greater than 6");
    }
  });
  dispose() {
    _email.close();
    _password.close();
    _loading.close();
    _valid.close();
  }
}
