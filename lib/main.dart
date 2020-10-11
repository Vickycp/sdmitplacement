import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/streams/firstcontollerbloc.dart';
import 'package:sdmitplacement/streams/listofblocs.dart';
import 'package:sdmitplacement/streams/secondcontrollerbloc.dart';
import 'package:sdmitplacement/view/auth/authcontroller.dart';

import 'package:sdmitplacement/view/controller/controller.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:MultiProvider(
        providers: ListofBloc.allbloc(),
        child: Controller()));
  }
}
