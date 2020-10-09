import 'package:flutter/material.dart';


class ProfilPage extends StatelessWidget {
 final String title;
  final Color colors;
  ProfilPage(this.title,this.colors);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colors,
        child: Text(title),
      ),
    );
  }
}
