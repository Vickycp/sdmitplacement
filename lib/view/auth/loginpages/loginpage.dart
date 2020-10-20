import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';
import 'package:sdmitplacement/view/auth/loginpages/loginbloc.dart';
import 'package:sdmitplacement/widgeds/errorwidgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Loginbloc _loginbloc = Loginbloc();
  bool passwordsecure = true;
  @override
  Widget build(BuildContext context) {
    // final secondcontrollerbloc = Provider.of<Secondcontrollerbloc>(context);
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
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: _loginbloc.errorstream,
                  initialData: null,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return showerror(snapshot.data, Colors.green);
                    }
                    if (snapshot.hasError) {
                      return showerror(snapshot.error, Colors.red);
                    }
                    return Container();
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                    stream: _loginbloc.email,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: _loginbloc.emailsink,
                        decoration: InputDecoration(
                            hintText: "email", errorText: snapshot.error),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                    stream: _loginbloc.password,
                    builder: (context, snapshot) {
                      return TextField(
                        obscureText: passwordsecure,
                        onChanged: _loginbloc.passwordsink,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: passwordsecure
                                  ? Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                    ),
                              onPressed: () {
                                setState(() {
                                  passwordsecure = !passwordsecure;
                                });
                              }),
                          hintText: "password",
                          errorText: snapshot.error,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                    onTap: () {
                      _loginbloc.forgetpassword();
                    },
                    child: Text("Forget Password"),
                  )
                ]),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                    stream: _loginbloc.enable,
                    initialData: false,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: (snapshot.data == true)
                            ? () {
                                setState(() {
                                  passwordsecure = true;
                                });
                                _loginbloc.login(context);
                              }
                            : null,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: (snapshot.data == true)
                                    ? Colors.white
                                    : Colors.grey[600],
                                borderRadius: BorderRadius.circular(10)),
                            height: 40,
                            width: 150,
                            child: StreamBuilder<Object>(
                                stream: _loginbloc.isloading,
                                initialData: false,
                                builder: (context, snapshot) {
                                  return (snapshot.data == true)
                                      ? CircularProgressIndicator()
                                      : Text("login");
                                })),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create a new account ?"),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: FlatButton(
                          onPressed: () {
                            BlocProvider.of<AuthblocBloc>(context)
                                .add(Signupbutton());
                          },
                          child: Text("signup"))),
                ],
              ),
              // google signin
              StreamBuilder(
                  stream: _loginbloc.googleloading,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: CircularProgressIndicator(backgroundColor:Colors.red,),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: SignInButton(
                        Buttons.Google,
                        text: "Signin with Google",
                        onPressed: () {
                          _loginbloc.googlesigin(context);
                        },
                      ),
                    );
                  }),
            ],
          ),
        ]),
      ),
    );
  }
}
