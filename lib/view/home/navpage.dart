import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/view/auth/authbackend/connections.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';
import 'package:sdmitplacement/view/home/homepage.dart';
import 'package:sdmitplacement/view/home/profilepage.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  HomeBloc bloc = HomeBloc();
  // FirebaseUser user;
  int _currentIndex = 0;
  // final List<Widget> _children = [
  //   Homepage(),
  //   ProfilPage("profile", Colors.blue),
  //   ProfilPage("profile", Colors.green)
  // ];

  childs(BuildContext context, current) {
    List<Widget> _children = [
      Homepage(),
      ProfilPage("profile", Colors.blue),
      ProfilPage("profile", Colors.green)
    ];
    return _children[current];
  }

  User user;
  @override
  void initState() {
    super.initState();
    user = Connections().getauth();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text(user.email),
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      bloc.isloginin.sink.add(false);
                    })
              ],
            ),
            // body: _children[_currentIndex],
            body: childs(context, _currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: new Icon(Icons.home), label: "home"),
                BottomNavigationBarItem(
                    icon: new Icon(Icons.mail), label: "mail"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "profile")
              ],
            )),
      )
    ;
  }
}
