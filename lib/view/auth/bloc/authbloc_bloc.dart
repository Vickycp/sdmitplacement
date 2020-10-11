import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  }

  Stream<AuthblocState> _checkingUser() async* {
    if (_userRepository.isSignedIn()) {
      yield Userpresent();
    } else {
      yield Authsignup();
    }
  }
}
