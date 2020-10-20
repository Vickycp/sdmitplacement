part of 'authbloc_bloc.dart';

@immutable
abstract class AuthblocEvent {}

class Sigininbutton extends AuthblocEvent {}

class Signupbutton extends AuthblocEvent {}

class Loginsubmit extends AuthblocEvent {}

class Createsubmit extends AuthblocEvent {}

class Appstarted extends AuthblocEvent {}

class Loadingevent extends AuthblocEvent {}

class Userauthsuccess extends AuthblocEvent {}

class Logoutevent extends AuthblocEvent {}

class Detailsevent extends AuthblocEvent {}

class SemDetailsevent extends AuthblocEvent {
  int sem;
  SemDetailsevent({this.sem});
}
