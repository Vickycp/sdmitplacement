import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Connections {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _store = FirebaseFirestore.instance;
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  signin({email, password}) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {});
  }

  signup({username, email, password}) async {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      _store
          .collection("studentcredential")
          .doc()
          .set({'username': username, "email": email, "password": password});
      return value.user;
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
}
