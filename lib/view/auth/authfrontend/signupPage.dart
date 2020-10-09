import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/view/auth/authbackend/connections.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signinPage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signinbloc.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';

// ignore: must_be_immutable
class SignupPage extends StatefulWidget {
  BuildContext context;
  SignupPage(this.context);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //emailtrue is used for hiding the hintText in the text field
  //password is also same as hiding the hintText of password textfield
  //showpassword is used to invisible the password for text field
  //usernametrue is used to hiding the hinttext in the textfield
  bool usernametrue = true,
      emailtrue = true,
      passwordtrue = true,
      showpassword = true,
      tickmark = false,
      passworderror = false,
      emailerror = false;
  //email variable is initilisation for storing the email of the user
  //password variable is initilisation for store the password of the user
  //confirmpassword is initilisation to store the user confirm password
  //username is initilisation for store the username
  String email, password, confirmpassword, username;
  SigninBloc signinbloc = SigninBloc();
  borders(Color color) {
    return OutlineInputBorder(borderSide: BorderSide(color: color, width: 2.0));
  }

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeBloc>(create: (_) => HomeBloc()),
      ],
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      //log of college
                      child: FlutterLogo(
                        size: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    //textfields for username
                    child: TextField(
                      onChanged: (value) {
                        username = value;
                      },
                      autofocus: false,
                      onTap: () {
                        setState(() {
                          usernametrue = !usernametrue;
                        });
                      },
                      decoration: InputDecoration(
                          focusedBorder: borders(Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedErrorBorder: borders(Colors.red),
                          hintText: usernametrue ? "username" : "",
                          labelText: "username"),
                    ),
                  ),
                  // text field for email
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        if (isEmail(value)) {
                          email = value;
                          setState(() {
                            emailerror = false;
                          });
                        } else {
                          setState(() {
                            emailerror = true;
                          });
                        }
                      },
                      autofocus: false,
                      onTap: () {
                        setState(() {
                          emailtrue = !emailtrue;
                        });
                      },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: borders(Colors.black),
                          focusedErrorBorder: borders(Colors.red),
                          errorText: emailerror ? "email not correct" : null,
                          hintText: emailtrue ? "example@sdmit.in" : "",
                          labelText: "example@sdmit.in"),
                    ),
                  ),
                  //text field for password
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        if (value.length >= 6) {
                          setState(() {
                            passworderror = false;
                          });

                          password = value;
                        } else {
                          setState(() {
                            passworderror = true;
                          });
                        }
                      },
                      onSubmitted: (value) {
                        print(password);
                      },
                      autofocus: false,
                      onTap: () {
                        setState(() {
                          passwordtrue = !passwordtrue;
                        });
                      },
                      obscureText: showpassword ? true : false,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: showpassword ? Colors.black : Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                showpassword = !showpassword;
                              });
                            },
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: borders(Colors.black),
                          focusedErrorBorder: borders(Colors.red),
                          hintText: passwordtrue ? "password" : "",
                          errorText: passworderror
                              ? "password must b grater than 6"
                              : null,
                          labelText: "password"),
                    ),
                  ),
                  //text field for confirm password
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        if (password == value) {
                          setState(() {
                            tickmark = false;
                          });
                        } else {
                          setState(() {
                            tickmark = true;
                          });
                        }
                      },
                      autofocus: false,
                      onTap: () {
                        setState(() {
                          passwordtrue = !passwordtrue;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: borders(Colors.black),
                          hintText: passwordtrue ? "confirm password" : "",
                          focusedErrorBorder: borders(Colors.red),
                          errorText: tickmark ? "password dosnot match" : null,
                          suffixIcon: tickmark
                              ? Icon(Icons.check, color: Colors.limeAccent[700])
                              : null,
                          labelText: "confirm password"),
                    ),
                  ),
                  //signup button
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      onTap: emailerror || tickmark
                          ? null
                          : () {
                              print(
                                  "$email,$password,$confirmpassword,$username");
                              // singup() methos is a property od connections class
                              // signinbloc.signup(
                              //     email: email,
                              //     username: username,
                              //     password: password);
                              final blocs = Provider.of<HomeBloc>(context,listen: false);
                              blocs.lo();
                            },
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: emailerror || tickmark
                                  ? Colors.grey[600]
                                  : Colors.white),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Signup")),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already hav a  account ?"),
                      Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text("signin"))),
                    ],
                  ),
                  //sigup with google account
                  SignInButton(
                    Buttons.Google,
                    text: "Signup with Google",
                    onPressed: () {
                      Connections().signupgoogle();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
