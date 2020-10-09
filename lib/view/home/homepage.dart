import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';


class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  @override
  Widget build(BuildContext context) {
  final blocs = Provider.of<HomeBloc>(context);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            blocs.logout();
          },
          child: Text("logout"),
        ),
      ),
    );
  }
}
