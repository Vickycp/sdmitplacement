import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdmitplacement/streams/rep.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';


class ListofBloc {
  static List<BlocProvider> allbloc() {
    return [
      BlocProvider<AuthblocBloc>(
          create: (BuildContext context) => AuthblocBloc(userRepository: UserRepository())..add(Appstarted())),
        
          
    ];
  }
}
