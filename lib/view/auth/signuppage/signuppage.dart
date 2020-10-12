import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
       padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
                  children:[ Column(


            children: [

               Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  //log  of the college
                  child: Center(
                    child: FlutterLogo(
                      size: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(labelText: "username",labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(labelText: "usn",labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(labelText: "email",labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: TextField(
                  onChanged: (value) {},
                 decoration: InputDecoration(labelText: "password",labelStyle: TextStyle(color: Colors.black)),
                ),
              ), Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: TextField(
                  onChanged: (value) {},
                 decoration: InputDecoration(labelText: "confirm password",labelStyle: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:.0,right: 10.0,top: 10.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("signup")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Already hava a account?"),
                    ),
                    GestureDetector(
                        onTap: () {
                         BlocProvider.of<AuthblocBloc>(context).add(Sigininbutton());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Signin",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                        )),
                  ],
                ),
              ),
              SignInButton(
                        Buttons.Google,
                        text: "Signup with Google",
                        onPressed: () {
                    
                        },
                      ),

            ],
          )]
        ),
      ),
    );
  }
}
