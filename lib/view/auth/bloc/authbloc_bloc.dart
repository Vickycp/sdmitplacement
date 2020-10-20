import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:sdmitplacement/streams/rep.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthblocBloc extends Bloc<AuthblocEvent, AuthblocState> {
  final UserRepository _userRepository;
  AuthblocBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthblocInitial());

  @override
  Stream<AuthblocState> mapEventToState(
    AuthblocEvent event,
  ) async* {
    print(event);
    if (event is Appstarted) {
      yield* _checkingUser();
    }
    if (event is Sigininbutton) {
      yield Authlogin();
    }
    if (event is Signupbutton) {
      yield Authsignup();
    }
    if (event is Loginsubmit) {
      yield Userpresent();
    }
    if (event is Createsubmit) {
      yield Userpresent();
    }
    if (event is Loadingevent) {
      yield Loading();
    }
    if (event is Userauthsuccess) {
      yield Userpresent();
    }
    if (event is Logoutevent) {
      yield* logoutstates();
    }
    if (event is Detailsevent) {
      yield DetailsState();
    }
    if (event is SemDetailsevent) {
      yield SemDetailsState(sem: event.sem);
    }
  }

  Stream<AuthblocState> logoutstates() async* {
    yield Loading();
    _userRepository.signOut();
    yield Authlogin();
  }

  Stream<AuthblocState> _checkingUser() async* {
    yield Loading();
    if (_userRepository.isSignedIn()) {
      yield Loading();
      await Future.delayed(Duration(milliseconds: 500));
      yield Userpresent();
    } else {
      yield Loading();
      await Future.delayed(Duration(milliseconds: 500));
      yield Authlogin();
    }
  }
}
