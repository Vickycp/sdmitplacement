part of 'authbloc_bloc.dart';

@immutable
abstract class AuthblocState {}

class AuthblocInitial extends AuthblocState {}

class Userpresent extends AuthblocState {}

class Authlogin extends AuthblocState {}

class Authsignup extends AuthblocState {}

class Loading extends AuthblocState {}

class DetailsState extends AuthblocState {}

class SemDetailsState extends AuthblocState {
  int sem;
  SemDetailsState({this.sem});
}
