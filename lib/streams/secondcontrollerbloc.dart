import 'package:rxdart/subjects.dart';

class Secondcontrollerbloc {
  BehaviorSubject<String> authpage;
  String initial = "login";
  Secondcontrollerbloc() {
    authpage = BehaviorSubject<String>.seeded(this.initial);
  }

  final signuppage = BehaviorSubject<String>();
  Stream<String> get authstream => authpage.stream;

  // Stream<String> get signupstream => signuppage.stream;
Sink<String> get authpsink => authpage.sink;
  // Sink<String> get authsink => authpage.sink;
  // Function(String) get signupsink => signuppage.sink.add;
  login() {
    authpage.sink.add("load");
    Future.delayed(Duration(seconds: 3)).then((value) {
      authpage.sink.add("login");
    });

    print(authpage.value);
  }

  signuo()async {
    authpsink.add("load");
    await Future.delayed(Duration(milliseconds: 500));
    authpage.sink.add("signup");

    print(authpage.value);
  }

  void dispose() {
    authpage.close();
    signuppage.close();
  }
}
