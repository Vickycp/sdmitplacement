import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/view/auth/authfrontend/adminpage.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signinbloc.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signupPage.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //emailtrue is used for hiding the hintText in the text field
  //password is also same as hiding the hintText of password textfield
  //showpassword is used to invisible the password for text field
  bool emailtrue = true, passwordtrue = true, showpassword = true;
  //email variable is initilisation for storing the email of the user
  //password variable is initilisation for store the password of the user
  String email, password;
  SigninBloc signinbloc = SigninBloc();
  borders(Color color) {
    return OutlineInputBorder(borderSide: BorderSide(color: color, width: 2.0));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
         Provider<HomeBloc>(create: (_) => HomeBloc()),
      ],
          child: Scaffold(
          //container with lightblueaccent color
          body: Container(
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blueGrey, Colors.lightBlueAccent]),
            ),
            // listview is used for scrolling effects of the text fields
            child: ListView(children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
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
                      height: 50,
                    ),
                    StreamBuilder<String>(
                      stream: signinbloc.validationStream,
                      initialData: "",
                      builder: (BuildContext context, snapshot) {
                        print(snapshot.data);
                        print(snapshot.error);
                        if (snapshot.hasData) {
                          return Container(
                            height: 30,
                            color: Colors.green,
                            child: Center(
                              child: Text(snapshot.data),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Container(
                            height: 30,
                            color: Colors.red,
                            child: Center(
                              child: Text(snapshot.error),
                            ),
                          );
                        }
                        return Center(
                          child: Text(snapshot.data),
                        );
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      //email Textfield
                      child: StreamBuilder<String>(
                          stream: signinbloc.emailstream,
                          builder: (context, snapshot) {
                            // print(snapshot.data);
                            print(snapshot.error);
                            return TextField(
                              onChanged: signinbloc.emailsink,
                              autofocus: false,
                              onTap: () {
                                setState(() {
                                  emailtrue = !emailtrue;
                                });
                              },
                              decoration: InputDecoration(
                                  focusedBorder: borders(Colors.black),
                                  focusedErrorBorder: borders(Colors.red),
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: emailtrue ? "email" : "",
                                  errorText: snapshot.error,
                                  labelText: "email"),
                            );
                          }),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                      // text field for password
                      child: StreamBuilder<String>(
                          stream: signinbloc.passwordstream,
                          builder: (context, snapshot) {
                            return TextField(
                              autofocus: false,
                              onChanged: signinbloc.passwordsink,
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
                                      color:
                                          showpassword ? Colors.black : Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showpassword = !showpassword;
                                      });
                                    },
                                  ),
                                  focusedBorder: borders(Colors.black),
                                  focusedErrorBorder: borders(Colors.red),
                                  labelStyle: TextStyle(color: Colors.black),
                                  errorText: snapshot.error,
                                  hintText: passwordtrue ? "password" : "",
                                  labelText: "password"),
                            );
                          }),
                    ),
                    // forget password section
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
                    // siginin button this contains a method sigini()
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                      child: StreamBuilder<bool>(
                          stream: signinbloc.loading,
                          builder: (context, snapshot) {
                            return GestureDetector(
                              onTap: () {
                                print('$email,$password');
                                signinbloc.submit();
                              },
                              child: Center(
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: (snapshot.hasData && snapshot.data)
                                          ? CircularProgressIndicator()
                                          : Text("Signin")),
                                ),
                              ),
                            );
                          }),
                    ),
                    //navigation to sigup page
                    Row(
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
                                          builder: (context) => SignupPage(context)));
                                },
                                child: Text("signup"))),
                      ],
                    ),
                    // google signin
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                      child: SignInButton(
                        Buttons.Google,
                        text: "Signin with Google",
                        onPressed: () {},
                      ),
                    ),
                    //navigation to admin page
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => AdminPage()));
                      },
                      child: Text("login as admin"),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
    );
    
  }
}
