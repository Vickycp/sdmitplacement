import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';
import 'package:sdmitplacement/view/auth/loginpages/loginpage.dart';
import 'package:sdmitplacement/view/auth/signuppage/signuppage.dart';
import 'package:sdmitplacement/view/home/homescreen.dart';
import 'package:sdmitplacement/widgeds/loading.dart';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthblocBloc, AuthblocState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is Loading) {
          return loading();
        }
        if (state is AuthblocInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Userpresent) {
          return HomeScreen();
        }
        if (state is Authlogin) {
          return LoginPage();
        }
        if (state is Authsignup) {
          return SignupPage();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

///
///final firstcontrollerbloc = Provider.of<Firstcontrollerbloc>(context);
// return StreamBuilder(
//   stream: _firstcontrollerbloc.useristhere,
//   builder: (context, snp) {
//     print(snp.data);
//     if (snp.hasData) {
//       if (snp.data == true) {
//         return HomeScreen();
//       }
//       return  AuthController();
//     }
//      return Center(child: CircularProgressIndicator(),);
//   },
// );
