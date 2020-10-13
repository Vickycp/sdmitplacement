import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';
import 'package:sdmitplacement/view/auth/signuppage/signupbloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String password, error;
  bool showpassword = true;

  SignupBloc _signupBloc = SignupBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(children: [
          Column(
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
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: _signupBloc.signupsuccess,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Text(
                          snapshot.error,
                          style: TextStyle(
                              color: Colors.black, fontStyle: FontStyle.italic),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.greenAccent[400],
                        alignment: Alignment.center,
                        child: Text(snapshot.data,
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic)),
                      );
                    }
                    return Container(
                      child: Text(""),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StreamBuilder(
                    stream: _signupBloc.usernamestream,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onChanged: _signupBloc.usernamesink,
                        decoration: InputDecoration(
                            errorText: snapshot.error,
                            labelText: "username",
                            labelStyle: TextStyle(color: Colors.black)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StreamBuilder(
                    stream: _signupBloc.usnstream,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onChanged: _signupBloc.usnsink,
                        decoration: InputDecoration(
                            errorText: snapshot.error,
                            labelText: "usn",
                            labelStyle: TextStyle(color: Colors.black)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StreamBuilder(
                    stream: _signupBloc.emailstream,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onChanged: _signupBloc.emailsink,
                        decoration: InputDecoration(
                            errorText: snapshot.error,
                            labelText: "email",
                            labelStyle: TextStyle(color: Colors.black)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StreamBuilder(
                    stream: _signupBloc.passwordstream,
                    builder: (context, snapshot) {
                      password = snapshot.data;
                      return TextField(
                        obscureText: showpassword,
                        textInputAction: TextInputAction.next,
                        onChanged: _signupBloc.passwordsink,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: showpassword
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    showpassword = !showpassword;
                                  });
                                }),
                            errorText: snapshot.error,
                            labelText: "password",
                            labelStyle: TextStyle(color: Colors.black)),
                      );
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: StreamBuilder(
                      stream: _signupBloc.confirmpassword,
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        return TextField(
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onChanged: (val) {
                            if (val != password) {
                              setState(() {
                                error = "T";
                              });
                              _signupBloc.confirmpasswordsink.add(val);
                            } else {
                              setState(() {
                                error = "F";
                              });
                            }
                            _signupBloc.matchpassword(val);
                          },
                          decoration: InputDecoration(
                              suffixIcon: (error == "F")
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    )
                                  : null,
                              errorText: error == "T"
                                  ? "password does not match"
                                  : null,
                              labelText: "confirm password",
                              labelStyle: TextStyle(color: Colors.black)),
                        );
                      })),
              Padding(
                padding:
                    const EdgeInsets.only(left: .0, right: 10.0, top: 10.0),
                child: StreamBuilder(
                    stream: _signupBloc.enable,
                    initialData: false,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: (snapshot.data == true)
                            ? () {
                                _signupBloc.signup(context);
                              }
                            : null,
                        child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: (snapshot.data == true)
                                  ? Colors.white
                                  : Colors.grey[600],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: StreamBuilder(
                                initialData: false,
                                stream: _signupBloc.loading,
                                builder: (context, snapshot) {
                                  if (snapshot.data == true) {
                                    return CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                  return Text("signup");
                                })),
                      );
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
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
                          BlocProvider.of<AuthblocBloc>(context)
                              .add(Sigininbutton());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Signin",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        )),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: _signupBloc.googleloading,
                  initialData: false,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    return SignInButton(
                      Buttons.Google,
                      text: "Signup with Google",
                      onPressed: () {
                        _signupBloc.googlesignup(context);
                      },
                    );
                  }),
            ],
          )
        ]),
      ),
    );
  }
}
