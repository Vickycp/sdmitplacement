import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdmitplacement/view/auth/authfrontend/signinPage.dart';
import 'package:sdmitplacement/view/home/homebloc.dart';
import 'package:sdmitplacement/view/home/navpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() {
    // ignore: deprecated_member_use
    FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      if (event!= null) {
        homeBloc.isloginin.sink.add(true);

      }else if(event==null){
          homeBloc.isloginin.sink.add(false);
      }else{
              homeBloc.isloginin.sink.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         Provider<HomeBloc>(create: (_) => HomeBloc()),
      ],

          child: StreamBuilder(
          stream: homeBloc.userpresent,
          builder: (context, snapshot) {
            print(snapshot.data);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: (snapshot.data == true) ? NavPage() : LoginPage(),
              // home:NavPage(),
            );
          }),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       // ignore: deprecated_member_use
//       stream:FirebaseAuth.instance.onAuthStateChanged,
//       builder: (context, snapshot) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             visualDensity: VisualDensity.adaptivePlatformDensity,
//           ),
//           home: (snapshot.data!=null)?NavPage():LoginPage(),
//           // home:NavPage(),
//         );
//       }
//     );
//   }
// }
