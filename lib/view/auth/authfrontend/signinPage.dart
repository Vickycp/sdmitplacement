import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool emailtrue = true, passwordtrue = true, showpassword = true;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: FlutterLogo(
                      size: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    autofocus: false,
                    onTap: () {
                      setState(() {
                        emailtrue = !emailtrue;
                      });
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: emailtrue ? "email" : "",
                        labelText: "email"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: TextField(
                    autofocus: false,
                    onChanged: (value) {
                      password = value;
                    },
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
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: passwordtrue ? "password" : "",
                        labelText: "password"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          print("forget password");
                        },
                        child: Text("Forget password"),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: GestureDetector(
                    onTap: () {
                      print('$email,$password');
                    },
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Align(
                            alignment: Alignment.center, child: Text("Signin")),
                      ),
                    ),
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Create a new account ?"),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                            child: Text("signup"))),
                  ],
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: SignInButton(
                    Buttons.Google,
                    text: "Signin with Google",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
