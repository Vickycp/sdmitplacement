import 'package:flutter/material.dart';
import 'package:sdmitplacement/view/auth/authbackend/connections.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signinPage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignupPage extends StatefulWidget {
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
      showpassword = true;
        //email variable is initilisation for storing the email of the user 
  //password variable is initilisation for store the password of the user
  //confirmpassword is initilisation to store the user confirm password
  //username is initilisation for store the username 
  String email, password, confirmpassword, username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: usernametrue ? "username" : "",
                        labelText: "username"),
                  ),
                ),
                // text field for email
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        hintText: emailtrue ? "example@sdmit.in" : "",
                        labelText: "example@sdmit.in"),
                  ),
                ),
                //text field for password
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: TextField(
                    onChanged: (value) {
                      password = value;
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
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        hintText: passwordtrue ? "password" : "",
                        labelText: "password"),
                  ),
                ),
                //text field for confirm password
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: TextField(
                    onChanged: (value) {
                      confirmpassword = value;
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
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        hintText: passwordtrue ? "confirm password" : "",
                        labelText: "confirm password"),
                  ),
                ),
                //signup button
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      print("$email,$password,$confirmpassword,$username");
                      // singup() methos is a property od connections class
                      Connections().signup(email: email, password: password,username: username);
                    },
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Align(
                            alignment: Alignment.center, child: Text("Signup")),
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
    );
  }
}
