import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                  height: 70,
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
                            alignment: Alignment.center, child: Text("Login")),
                      ),
                    ),
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