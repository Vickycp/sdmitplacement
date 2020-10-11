import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/streams/secondcontrollerbloc.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {},
              decoration: InputDecoration(hintText: "email"),
            ),
            TextField(
              onChanged: (value) {},
              decoration: InputDecoration(hintText: "password"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("signup"),
            ),
            FlatButton(
                onPressed: () {
                 BlocProvider.of<AuthblocBloc>(context).add(Sigininbutton());
                },
                child: Text("login"))
          ],
        ),
      ),
    );
  }
}
