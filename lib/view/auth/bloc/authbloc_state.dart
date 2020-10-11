part of 'authbloc_bloc.dart';

@immutable
abstract class AuthblocState {}

class AuthblocInitial extends AuthblocState {
 
}

class Userpresent extends AuthblocState {}

class Authlogin extends AuthblocState {}

class Authsignup extends AuthblocState {}
