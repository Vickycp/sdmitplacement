import 'package:rxdart/subjects.dart';

class SignupBloc {
   final  _username = BehaviorSubject<String>();
  final _usn = BehaviorSubject<String>();
  final  _email = BehaviorSubject<String>();
  final  _password = BehaviorSubject<String>();
  final  _confirmpassword = BehaviorSubject<String>();

  Stream<String> get usernamestream => _username.stream;
  Stream<String> get usnstream => _username.stream;
  // Stream<String> get  => _username.stream;
  // Stream<String> get usernamestream => _username.stream;
  // Stream<String> get usernamestream => _username.stream;
  

  void dispose() {
    _username.close();
    _usn.close();
    _email.close();
    _password.close();
    _confirmpassword.close();
  }
}
