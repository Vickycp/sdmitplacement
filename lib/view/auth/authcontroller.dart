import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/streams/secondcontrollerbloc.dart';
import 'package:sdmitplacement/view/auth/loginpage.dart';
import 'package:sdmitplacement/view/auth/signuppage.dart';

class AuthController extends StatefulWidget {
  @override
  _AuthControllerState createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  Secondcontrollerbloc _secondcontrollerbloc = Secondcontrollerbloc();
  @override
  Widget build(BuildContext context) {
    // final secondcontrollerbloc = Provider.of<Secondcontrollerbloc>(context);
    return StreamBuilder(
        stream: Secondcontrollerbloc().authstream,
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.data == "load") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == "login") {
            return LoginPage();
          }
          if (snapshot.data == "signup") {
            return SignupPage();
          }
          return LoginPage();
        });
  }
}
