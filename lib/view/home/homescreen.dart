import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: GestureDetector(
        onTap: (){
          BlocProvider.of<AuthblocBloc>(context).add(Logoutevent());
        },
        child: Text("home")),
    )));
  }
}
