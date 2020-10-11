import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/streams/secondcontrollerbloc.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class LoginPage extends StatelessWidget {
  Secondcontrollerbloc secondcontrollerbloc = Secondcontrollerbloc();
  @override
  Widget build(BuildContext context) {
    // final secondcontrollerbloc = Provider.of<Secondcontrollerbloc>(context);
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
              child: Text("login"),
            ),
            FlatButton(
                onPressed: () {
                  BlocProvider.of<AuthblocBloc>(context).add(Signupbutton());
                },
                child: Text("signup"))
          ],
        ),
      ),
    );
  }
}
