import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';

class Connections {
  HomeBloc homebloc = HomeBloc();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _store = FirebaseFirestore.instance;
  UserCredential _userCredential;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  signin({email, password}) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _userCredential = value;
    });
  }

  signup({username, email, password, context}) async {
    final blocs = Provider.of<HomeBloc>(context);
    CircularProgressIndicator(
      backgroundColor: Colors.red,
    );
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      _store
          .collection("studentcredential")
          .doc()
          .set({'username': username, "email": email, "password": password});
      Fluttertoast.showToast(
          msg: "signup successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 10.0);
      blocs.isloginin.sink.add(true);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);
      blocs.isloginin.sink.add(false);
    });
  }

  signupgoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // ignore: deprecated_member_use
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential result = await auth.signInWithCredential(credential);
    print(result);
  }

  User getauth() {
    return auth.currentUser;
  }

  signout() async {
    auth.signOut();
    homebloc.isloginin.sink.add(false);
  }
}
